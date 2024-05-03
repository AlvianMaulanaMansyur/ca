// ignore_for_file: sort_child_properties_last

import 'package:calorie_v2/main.dart';
import 'package:flutter/material.dart';

class calculateCalorie extends StatelessWidget {
  final List food;

  calculateCalorie({
    super.key,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          double totalCalories = 0.0;
          for (int i = 0; i < food.length; i++) {
            totalCalories += food[i]['calories'];
          }
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('TOTAL CALORIES'),
                content: Text(
                    'The total calories of all foods are: $totalCalories kkal'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('close'),
                  ),
                ],
              );
            },
          );
        },
        child: const Padding(
          padding:  EdgeInsets.all(12.0),
          child:  Text(
            'Count Calorie',
            style: TextStyle(color: Colors.white),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: MyApp.primaryColor,
        ),
      ),
    );
  }
}
