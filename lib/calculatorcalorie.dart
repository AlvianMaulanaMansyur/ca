import 'package:calorie_v2/main.dart';
import 'package:calorie_v2/util/calculatecalorie.dart';
import 'package:calorie_v2/util/dialogbox.dart';
import 'package:calorie_v2/util/food_tile.dart';
import 'package:flutter/material.dart';

class CalculatorCalorie extends StatefulWidget {
  const CalculatorCalorie({super.key});

  @override
  State<CalculatorCalorie> createState() => _CalculatorCalorieState();
}

class _CalculatorCalorieState extends State<CalculatorCalorie> {
  List food = [];

  void foodAdd(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogBox(foodAdded: (
            String foodName,
            double caloriePerFood,
          ) {
            setState(() {
              food.add({
                'name': foodName,
                'calories': caloriePerFood,
              });
            });
          });
        });
  }

  void deleteFood(int index) {
    setState(() {
      food.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Calorie Calculator",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: MyApp.primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => foodAdd(context),
        backgroundColor: MyApp.primaryColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: food.length,
                itemBuilder: (BuildContext context, int index) {
                  return FoodTile(
                    foodName: food[index]['name'],
                    calorie: food[index]['calories'],
                    onDelete: () => deleteFood(index),
                  );
                },
              ),
            ),
            calculateCalorie(food: food),
          ],
        ),
      ),
    );
  }
}
