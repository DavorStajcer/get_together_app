import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_together_app/core/widgets/user_star_rating.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/event_card_order_cubit/event_card_order_cubit.dart';

class EventAdmin extends StatelessWidget {
  final String imageUrl;
  final EventType eventType;
  final String username;
  final int numberOfPeople;
  const EventAdmin({
    Key? key,
    required this.imageUrl,
    required this.eventType,
    required this.username,
    required this.numberOfPeople,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 20, left: 5, top: 5, bottom: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl),
                      ),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Container(
                width: 20,
                height: 20,
                margin: EdgeInsets.only(right: 15),
                child: Image.asset(
                  eventType == EventType.coffe
                      ? "lib/assets/images/coffe.png"
                      : eventType == EventType.food
                          ? "lib/assets/images/food.png"
                          : "lib/assets/images/game.png",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 16,
                child: AutoSizeText(
                  "$numberOfPeople people",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                height: 30,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              UserStarRating(rating: 5),
            ],
          ),
        ),
      ],
    );
  }
}
