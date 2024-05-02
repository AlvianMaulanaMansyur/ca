import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final String foodName;
  final double calorie;
  FoodTile({super.key, required this.foodName, required this.calorie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              // Checkbox(value: value, onChanged: onChanged)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodName,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(calorie.toStringAsFixed(2))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
