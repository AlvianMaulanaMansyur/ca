import 'package:calorie_v2/main.dart';
import 'package:calorie_v2/util/calculatecalorie.dart';
import 'package:calorie_v2/util/dialogbox.dart';
import 'package:calorie_v2/util/food_tile.dart';
import 'package:calorie_v2/profile.dart';
import 'package:flutter/material.dart';
import 'package:calorie_v2/db/database_helper.dart'; // import DatabaseHelper

class CalculatorCalorie extends StatefulWidget {
  const CalculatorCalorie({super.key});

  @override
  State<CalculatorCalorie> createState() => _CalculatorCalorieState();
}

class _CalculatorCalorieState extends State<CalculatorCalorie> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> food = [];

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  void _loadFoods() async {
    List<Map<String, dynamic>> foods = await DatabaseHelper().getFoods();
    setState(() {
      food = List<Map<String, dynamic>>.from(
          foods); // Membuat daftar yang dapat dimodifikasi
    });
  }

  void foodAdd(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogBox(foodAdded: (
            String foodName,
            double caloriePerFood,
          ) async {
            Map<String, dynamic> newFood = {
              'name': foodName,
              'calories': caloriePerFood,
            };
            int id = await DatabaseHelper().insertFood(newFood);
            if (id != 0) {
              print("Data berhasil dimasukkan dengan ID: $id");
              newFood['id'] = id; // Menambahkan ID ke item baru
              setState(() {
                food.add(newFood);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Food added successfully!")));
            } else {
              print("Gagal memasukkan data");
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Failed to add food.")));
            }
          });
        });
  }

  void deleteFood(int index) async {
    int id = food[index]['id'];
    await DatabaseHelper().deleteFood(id);
    setState(() {
      food.removeAt(index);
    });
  }

  void editFood(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController nameController =
              TextEditingController(text: food[index]['name']);
          TextEditingController calorieController =
              TextEditingController(text: food[index]['calories'].toString());

          return AlertDialog(
            title: const Text('Edit Food'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Food Name'),
                ),
                TextField(
                  controller: calorieController,
                  decoration: const InputDecoration(labelText: 'Calories'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  String newName = nameController.text;
                  double newCalories =
                      double.tryParse(calorieController.text) ?? 0.0;

                  Map<String, dynamic> updatedFood = {
                    'name': newName,
                    'calories': newCalories,
                  };

                  int id = food[index]['id'];
                  await DatabaseHelper().updateFood(id, updatedFood);

                  setState(() {
                    food[index] = {
                      'id': id,
                      'name': newName,
                      'calories': newCalories,
                    };
                  });

                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          );
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
                          onEdit: () => editFood(context, index),
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
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyApp.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
