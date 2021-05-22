import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_together_app/core/error/failure.dart';
import 'package:get_together_app/features/events_overview/domain/entities/event.dart';
import 'package:get_together_app/features/single_event_overview/domain/entities/event_join_data.dart';
import 'package:get_together_app/features/single_event_overview/domain/usecase/change_user_join_status.dart';
import 'package:get_together_app/features/single_event_overview/domain/usecase/check_is_user_joined.dart';

part 'join_event_state.dart';

class JoinEventCubit extends Cubit<JoinEventState> {
  final CheckIsUserJoined checkIsUserJoined;
  final ChangeUserJoinStatus changeUserJoinStatus;
  JoinEventCubit({
    required this.changeUserJoinStatus,
    required this.checkIsUserJoined,
  }) : super(JoinEventLoading());

  void geUserJoinedStatus(BuildContext context, Event event) async {
    final response = await checkIsUserJoined(event);
    log("GOT RESPONSE -> $response");
    response.fold((failure) {
      log("SOME FAILURE");
      if (failure is NetworkFailure)
        emit(JoinEventNetworkFailure(failure.message));
      else
        emit(JoinEventServerFailure(failure.message));
    }, (isJoined) {
      print("IS JOINDE -> $isJoined");
      if (isJoined)
        emit(JoinEventFinished(buttonData: ButtonJoinedUi(context)));
      else
        emit(JoinEventFinished(buttonData: ButtonNotJoinedUi(context)));
    });
  }

  void changeJoinedStatus(
      BuildContext context, EventJoinData eventJoinData) async {
    emit(JoinEventLoading());
    final response = await changeUserJoinStatus(eventJoinData);
    response.fold((failure) {
      log("SOME FAILURE WHILE CHANGING JOIN STATUS");
      if (failure is NetworkFailure)
        emit(JoinEventNetworkFailure(failure.message));
      else
        emit(JoinEventServerFailure(failure.message));
    }, (success) {
      if (eventJoinData.eventChange == EventChange.join)
        emit(JoinEventFinished(buttonData: ButtonJoinedUi(context)));
      else
        emit(JoinEventFinished(buttonData: ButtonNotJoinedUi(context)));
    });
  }
}
