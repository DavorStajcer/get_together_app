import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  const Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              "Decription",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 5,
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(),
              ),
              Flexible(
                flex: 13,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Text(
                    "Some long description of a event made by who else than CJ. Perfect black man. Has guns, money, drugs, alcohol, women and most of all respect. He earns respect +100 on a daily basis. Thats just who he is. A bad madakafa. Paka paka pakaaa madakafa.",
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
