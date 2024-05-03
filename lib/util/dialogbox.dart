import 'package:calorie_v2/main.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final Function(String, double) foodAdded;
  const DialogBox({super.key, required this.foodAdded});

  @override
  Widget build(BuildContext context) {
    String foodName = '';
    double caloriePerFood = 0.0;

    return AlertDialog(
      title: const Text('Add Your Food'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
                decoration: const InputDecoration(
                    labelText: 'Food Name',
                    labelStyle: TextStyle(color: MyApp.primaryColor)),
                onChanged: (value) {
                  foodName = value;
                }),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Calorie Per Food (kkal)',
                  labelStyle: TextStyle(color: MyApp.primaryColor)),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                caloriePerFood = double.tryParse(value) ?? 0.0;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            foodAdded(foodName, caloriePerFood);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: MyApp.primaryColor),
          child: const Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
