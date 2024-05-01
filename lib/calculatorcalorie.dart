
import 'package:calorie_v2/main.dart';
import 'package:calorie_v2/util/dialogbox.dart';
import 'package:flutter/material.dart';

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

  final _controller = TextEditingController();

  List food = [];

  void saveNewFood() {
    setState(() {
      food.add([_controller.text, false]);
    });
  }

  void addFood() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewFood,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
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
          onPressed: addFood,
          backgroundColor: MyApp.primaryColor,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
