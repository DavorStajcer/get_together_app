import 'package:flutter/material.dart';

class EventAdmin extends StatelessWidget {
  const EventAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  30,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
                  ),
                  color: Colors.grey,
                ),
              ),
            ),
          ), /* Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: ClipPath(
              clipper: AdminImageClipper(),
              child: AdminPicture(),
            ),
          ), */
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "2 people",
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                "Daca",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      Text(
                        "(20)",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
