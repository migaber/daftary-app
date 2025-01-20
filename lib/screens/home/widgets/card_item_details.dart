import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Direction { up, down }

class CardItemDetails extends StatelessWidget {
  final String title;
  final Direction direction;
  final int amount;

  const CardItemDetails({
    super.key,
    required this.title,
    required this.direction,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white54,
            ),
          ),
          Icon(
            direction == Direction.up
                ? CupertinoIcons.arrow_up
                : CupertinoIcons.arrow_down,
            color: direction == Direction.up
                ? Colors.red.shade400
                : Colors.green.shade400,
            size: 12,
          )
        ],
      ),
      SizedBox(
        width: 8,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white54,
          ),
        ),
        Text(
          "${amount.toString()} LE",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        )
      ]),
    ]);
  }
}
