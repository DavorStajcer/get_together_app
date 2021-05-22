import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_together_app/core/error/success.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:get_together_app/core/maps/location_service.dart';
import 'package:get_together_app/core/network.dart/network_info.dart';
import 'package:get_together_app/features/events_overview/domain/entities/event.dart';
import 'package:get_together_app/features/single_event_overview/domain/entities/event_join_data.dart';
import 'package:get_together_app/features/single_event_overview/domain/repositoires/user_events_repository.dart';

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
  Future<Either<Failure, Success>> changeUserJoinStatus(
      EventJoinData eventJoinData) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) return Left(NetworkFailure());

    final User? currentUser = firebaseAuth.currentUser;
    if (currentUser == null)
      return Left(ServerFailure(message: "Problem identifyng current user"));
    final currentUserId = currentUser.uid;

    final String? eventCity =
        await locationService.mapLocationToCity(eventJoinData.event.location);
    if (eventCity == null)
      return Left(ServerFailure(message: "Problem identifyng event location"));

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
      final String userImageUrl = userData["imageUrl"];
      if (eventJoinData.eventChange == EventChange.join)
        await firebaseFirestore
            .collection("events")
            .doc(eventCity)
            .collection("city_events")
            .doc(eventJoinData.event.eventId)
            .update({"peopleImageUrls.$currentUserId": userImageUrl});
      else
        await firebaseFirestore
            .collection("events")
            .doc(eventCity)
            .collection("city_events")
            .doc(eventJoinData.event.eventId)
            .update({"peopleImageUrls.$currentUserId": FieldValue.delete()});
      return Right(Success());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> checkIsUserJoined(Event event) async {
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
        return Right(false);
      }
      final listOfUserJoinedEvents = List.from(data["eventIds"]);
      bool isUserJoined = false;
      listOfUserJoinedEvents.forEach((userEventId) {
        if (userEventId == event.eventId) isUserJoined = true;
      });
      return Right(isUserJoined);
    } catch (e) {
      return Left(ServerFailure());
    }
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
