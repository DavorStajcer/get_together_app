import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_together_app/core/error/success.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:get_together_app/core/maps/location_service.dart';
import 'package:get_together_app/core/network.dart/network_info.dart';
import 'package:get_together_app/features/events_overview/domain/entities/event.dart';
import 'package:get_together_app/features/notifications_overview/data/models/notification_model.dart';
import 'package:get_together_app/features/notifications_overview/presentation/widgets/join_request.dart';
import 'package:get_together_app/features/single_event_overview/domain/repositoires/user_events_repository.dart';

enum UserJoinStatus { joined, requested, not }

class UserEventsRepositoryImpl extends UserEventsRepository {
  final NetworkInfo networkInfo;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final LocationService locationService;
  UserEventsRepositoryImpl({
    required this.networkInfo,
    required this.locationService,
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firebaseFirestore,
  })  : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<Either<Failure, Success>> removeUserFromEvent(Event event) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) return Left(NetworkFailure());
    final User? currentUser = firebaseAuth.currentUser;
    if (currentUser == null)
      return Left(ServerFailure(message: "Problem identifyng current user"));
    final currentUserId = currentUser.uid;
    try {
      final userDocSnapshot =
          await firebaseFirestore.collection("users").doc(currentUserId).get();
      final userData = userDocSnapshot.data();
      if (userData == null)
        return Left(
          ServerFailure(
            message:
                "Not able to get your user data at the moment. Please try again later.",
          ),
        );
      final city = await locationService.mapLocationToCity(event.location);
      if (city == null) return Left(ServerFailure(message: "Location problem"));
      await firebaseFirestore
          .collection("events")
          .doc(city)
          .collection("city_events")
          .doc(event.eventId)
          .update({"peopleImageUrls.$currentUserId": FieldValue.delete()});
      return Right(Success());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Success>> declineJoinRequest(
      JoinEventNotificationModel notification) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) return Left(NetworkFailure());
    final User? currentUser = firebaseAuth.currentUser;
    if (currentUser == null)
      return Left(ServerFailure(message: "Problem identifyng current user"));
    final currentUserId = currentUser.uid;
    try {
      await firebaseFirestore
          .collection("users")
          .doc(currentUserId)
          .collection("user_notifications")
          .doc(notification.notificationId)
          .update({
        "resolvedStatus": NotificationResolved.rejected.index,
      });
      return Right(Success());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Success>> joinUserToEvent(
      JoinEventNotificationModel notification) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) return Left(NetworkFailure());
    final User? currentUser = firebaseAuth.currentUser;
    if (currentUser == null)
      return Left(ServerFailure(message: "Problem identifyng current user"));
    final currentUserId = currentUser.uid;
    try {
      await firebaseFirestore
          .collection("events")
          .doc(notification.eventCity)
          .collection("city_events")
          .doc(notification.eventId)
          .update({
        "peopleImageUrls.${notification.senderId}": notification.senderImageUrl
      });
      await firebaseFirestore
          .collection("users")
          .doc(currentUserId)
          .collection("user_notifications")
          .doc(notification.notificationId)
          .update({
        "resolvedStatus": NotificationResolved.accepted.index,
      });
      return Right(Success());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserJoinStatus>> checkIsUserJoined(Event event) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) return Left(NetworkFailure());
    final User? currentUser = firebaseAuth.currentUser;
    if (currentUser == null)
      return Left(ServerFailure(message: "Problem identifyng current user"));
    final currentUserId = currentUser.uid;
    final String? eventCity =
        await locationService.mapLocationToCity(event.location);
    if (eventCity == null)
      return Left(ServerFailure(message: "Problem identifyng event location"));
    try {
      final eventCityRef = firebaseFirestore
          .collection("users")
          .doc(currentUserId)
          .collection("user_events")
          .doc(eventCity);
      final dataSnapshot = await eventCityRef.get();
      final data = dataSnapshot.data();

      if (data == null) {
        return Right(UserJoinStatus.not);
      }
      final listOfUserJoinedEvents = List.from(data["eventIds"]);
      UserJoinStatus isUserJoined = UserJoinStatus.not;
      listOfUserJoinedEvents.forEach((userEventId) {
        if (userEventId == event.eventId) isUserJoined = UserJoinStatus.joined;
      });
      if (isUserJoined != UserJoinStatus.joined)
        isUserJoined = await _isJoinRequested(currentUserId, event.eventId);
      return Right(isUserJoined);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<UserJoinStatus> _isJoinRequested(String userId, String eventId) async {
    final requestDocSnapshot = await firebaseFirestore
        .collection("users")
        .doc(userId)
        .collection("sent_requests")
        .doc(eventId)
        .get();
    if (requestDocSnapshot.exists)
      return UserJoinStatus.requested;
    else
      return UserJoinStatus.not;
  }

  @override
  Future<Either<Failure, List<String>>> getAllUserEvents() async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) return Left(NetworkFailure());
    final currentUser = firebaseAuth.currentUser;
    if (currentUser == null) return Left(ServerFailure());
    final currentUserId = currentUser.uid;
    try {
      final userEventsSnapshot = await firebaseFirestore
          .collection("users")
          .doc(currentUserId)
          .collection("user_events")
          .get();

      final List<String> allUserEvents = [];
      userEventsSnapshot.docs.forEach((city) {
        final docData = city.data();
        final adminIds = docData["adminIds"] as List<dynamic>;
        final memberIds = docData["eventIds"] as List<dynamic>;
        adminIds.forEach((eventId) {
          allUserEvents.add(eventId);
        });
        memberIds.forEach((eventId) {
          allUserEvents.add(eventId);
        });
      });
      return Right(allUserEvents);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
