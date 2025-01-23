import 'dart:math';

import 'package:daftary/screens/home/widgets/card_item_details.dart';
import 'package:flutter/material.dart';

class HomePageCreditcard extends StatelessWidget {
  const HomePageCreditcard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).toInt()), // Shadow color
            blurRadius: 10, // Softness of the shadow
            spreadRadius: 1, // Size of the shadow
            offset: Offset(0, 4), // Position of the shadow (x, y)
          ),
        ],
        gradient: LinearGradient(
          transform: const GradientRotation(0.6 * pi),
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.primary,
          ],
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 28.0),
        child: Column(children: [
          Text(
            "Total Balance",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "17,300 LE",
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardItemDetails(
                title: "Income",
                direction: Direction.down,
                amount: 13453,
              ),
              CardItemDetails(
                title: "Expenses",
                direction: Direction.up,
                amount: 9003,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
