import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get_together_app/core/widgets/user_star_rating.dart';

class EventAdmin extends StatelessWidget {
  const EventAdmin({Key? key}) : super(key: key);

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
                        image: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
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
                  "lib/assets/images/coffe.png",
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
                  "2 people",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Container(
                width: 50,
                height: 30,
                child: AutoSizeText(
                  "Daca",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
