// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calorie_v2/main.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "About this APP",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Lato',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: MyApp.primaryColor,
      ),
      body: Column(
        children:[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 19.0, top: 30.0),
              child: const Text(
                'CALORIE CALCULATOR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17.0, right: 17.0),
            child: Text(
                textAlign: TextAlign.justify,
                style: TextStyle(),
                'Welcome to Calorie Calculator, your ultimate companion in achieving a healthier, more balanced lifestyle. Whether you are aiming to lose weight, gain muscle, or maintain your current physique, our app provides the tools you need to reach your goals effortlessly.'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 19.0),
            child: Text(
              'Stay Motivated and Reach Your Goals    ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
            Padding(
            padding: const EdgeInsets.only(left: 17.0, right: 17.0),
            child: Text(
                textAlign: TextAlign.justify,
                style: TextStyle(),
                'Join a community of health enthusiasts and get inspired by their journeys. Share your progress, exchange tips, and celebrate milestones together. Our app also offers motivational reminders and tips to keep you focused and driven.'),
          ),
        ],
      ),
    );
  }
}
