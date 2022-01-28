import 'package:flutter/material.dart';
import 'package:new_one_life/default/colors.dart';

class Prices extends StatelessWidget {
  final String? firstPrice;
  final String? secondPrice;
  final double? firstPriceSize;
  final double? secondPriceSize;

  Prices(
      {Key? key,
      this.firstPrice,
      this.secondPrice,
      this.firstPriceSize,
      this.secondPriceSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstPrice!,
          style: TextStyle(
              color: priceColor,
              fontWeight: FontWeight.bold,
              fontSize: firstPriceSize),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          secondPrice!,
          style: TextStyle(
              color: addressColor,
              fontWeight: FontWeight.bold,
              fontSize: secondPriceSize,
              decoration: TextDecoration.lineThrough),
        ),
      ],
    );
  }
}
