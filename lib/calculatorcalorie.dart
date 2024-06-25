import 'package:calorie_v2/main.dart';
import 'package:calorie_v2/util/calculatecalorie.dart';
import 'package:calorie_v2/util/dialogbox.dart';
import 'package:calorie_v2/util/food_tile.dart';
import 'package:calorie_v2/profile.dart';
import 'package:flutter/material.dart';

class CalculatorCalorie extends StatefulWidget {
  const CalculatorCalorie({super.key});

  @override
  State<CalculatorCalorie> createState() => _CalculatorCalorieState();
}

class _CalculatorCalorieState extends State<CalculatorCalorie> {
  int _selectedIndex = 0;
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      Scaffold(
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
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/img/bg1.png',
                ),
              ),
            ),
            Padding(
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
          ],
        ),
      ),
      const ProfileScreen(), // Use SettingsScreen widget
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyApp.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
