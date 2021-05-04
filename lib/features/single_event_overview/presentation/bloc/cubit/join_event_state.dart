part of 'join_event_cubit.dart';

abstract class JoinEventState extends Equatable {
  const JoinEventState();

  @override
  List<Object> get props => [];
}

class JoinEventInitial extends JoinEventState {}

class JoinEventFinished extends JoinEventState {
  final ButtonJoinUiData buttonData;
  JoinEventFinished({required this.buttonData});
  @override
  List<Object> get props => [buttonData];
}

abstract class ButtonJoinUiData {
  final Color color;
  final String text;
  ButtonJoinUiData(this.color, this.text);
}

class ButtonJoinedUi extends ButtonJoinUiData {
  ButtonJoinedUi(Color color, String text) : super(color, text);
}

class ButtonNotJoinedUi extends ButtonJoinUiData {
  ButtonNotJoinedUi(Color color, String text) : super(color, text);
}
