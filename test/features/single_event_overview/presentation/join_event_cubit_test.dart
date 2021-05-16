//@dart=2.6

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_together_app/features/single_event_overview/domain/usecase/change_user_join_status.dart';
import 'package:get_together_app/features/single_event_overview/domain/usecase/check_is_user_joined.dart';
import 'package:get_together_app/features/single_event_overview/presentation/bloc/join_event_cubit/join_event_cubit.dart';
import 'package:mockito/mockito.dart';

class CheckIsUserJoinedMock extends Mock implements CheckIsUserJoined {}

class ChangeUserJoinStatusMock extends Mock implements ChangeUserJoinStatus {}

void main() {
  CheckIsUserJoinedMock checkIsUserJoinedMock;
  ChangeUserJoinStatusMock changeUserJoinStatusMock;
  JoinEventCubit joinEventCubit;

  setUp(() {
    checkIsUserJoinedMock = CheckIsUserJoinedMock();
    changeUserJoinStatusMock = ChangeUserJoinStatusMock();
    joinEventCubit = JoinEventCubit(
      changeUserJoinStatus: changeUserJoinStatusMock,
      checkIsUserJoined: checkIsUserJoinedMock,
    );
  });

  test("inital state should be JoinEventLoading", () {
    expect(joinEventCubit.state, JoinEventLoading());
  });

  //getUserJoinedStatus()
}
