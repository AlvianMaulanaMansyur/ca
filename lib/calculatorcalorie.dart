import 'package:calorie_v2/main.dart';
import 'package:calorie_v2/util/dialogbox.dart';
import 'package:calorie_v2/util/food_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CalculatorCalorie extends StatefulWidget {
  const CalculatorCalorie({super.key});

  @override
  State<CalculatorCalorie> createState() => _CalculatorCalorieState();
}

class _CalculatorCalorieState extends State<CalculatorCalorie> {
  // void _addFood(BuildContext context) {
  //   List<Map<String, dynamic>> foods = [];
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       String foodName = '';
  //       double caloriePerFood = 0.0;

  //       return Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Text(
  //               'Tambahkan Makanan',
  //               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
  //             ),
  //             const SizedBox(height: 20.0),
  //             TextField(
  //               decoration: const  InputDecoration(labelText: 'Nama Makanan'),
  //               onChanged: (value) {
  //                 setState(() {
  //                   foodName = value;
  //                 });
  //               },
  //             ),
  //             const SizedBox(height: 20.0),
  //             TextField(
  //               decoration: const  InputDecoration(labelText: 'Kalori per Makanan'),
  //               keyboardType: TextInputType.number,
  //               onChanged: (value) {
  //                 setState(() {
  //                   caloriePerFood = double.tryParse(value) ?? 0.0;
  //                 });
  //               },
  //             ),
  //             const SizedBox(height: 20.0),
  //             ElevatedButton(
  //               onPressed: () {
  //                 setState(() {
  //                   foods.add({
  //                     'name': foodName,
  //                     'calories': caloriePerFood,
  //                   });
  //                 });
  //                 Navigator.pop(
  //                     context); // Tutup modal setelah menambahkan makanan
  //               },
  //               child: const Text('Tambahkan'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  List food = [];

  void foodAdd(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogBox(foodAdded: (String foodName, double caloriePerFood) {
            setState(() {
              food.add({'name': foodName, 'calories': caloriePerFood});
            });
          });
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
                fontWeight: FontWeight.bold),
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
            )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.0,
                child: Expanded(
                    child: ListView.builder(
                  itemCount: food.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FoodTile(
                      foodName: food[index]['name'],
                      calorie: food[index]['calories'],
                    );
                  },
                )),
              )
            ],
          ),
        ));
  }
}
