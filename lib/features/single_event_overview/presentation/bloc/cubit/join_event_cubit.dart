import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'join_event_state.dart';

class JoinEventCubit extends Cubit<JoinEventState> {
  JoinEventCubit() : super(JoinEventInitial());

  void checkIsUserJoined() {}

  void changeJoinedStatus() {}
}
