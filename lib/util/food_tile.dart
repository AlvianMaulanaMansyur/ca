import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  final String foodName;
  final double calorie;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  FoodTile({
    required this.foodName,
    required this.calorie,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            title: Text(
              foodName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            subtitle: Text('Kalori: $calorie kkal'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
