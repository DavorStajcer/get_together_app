import 'package:get_together_app/features/make_event/presentation/blocs/event_card_order_cubit/event_card_order_cubit.dart';

abstract class OrderModifier {
  List<EventType> moveToTop(List<EventType> order, EventType eventType);
}

class OrderModifierImpl implements OrderModifier {
  @override
  List<EventType> moveToTop(List<EventType> order, EventType eventType) {
    print([
      EventType.games.index,
      EventType.coffe.index,
      EventType.food.index,
    ]);
    List<EventType> sortedList = EventCardOrderInitial().eventTypeOrder;
    final List<EventType> newList = [];
    newList.add(eventType);

    sortedList.forEach((element) {
      if (element != eventType) newList.add(element);
    });
    print("NEW LIST -> $newList");
    return newList;
  }
}
