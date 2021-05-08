import 'package:flutter/material.dart';

class PoepleComming extends StatelessWidget {
  const PoepleComming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            height: double.infinity,
            alignment: Alignment.topLeft,
            child: Text(
              "People",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 13,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (ctx, index) => Container(
                    height: double.infinity,
                    width: 35,
                    child: Column(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "https://i.imgur.com/BoN9kdC.png"),
                            ),
                            color: Colors.grey,
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            "Thompson",
                          ),
                        ),
                      ],
                    ),
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
