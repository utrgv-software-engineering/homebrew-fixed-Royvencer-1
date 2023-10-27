import 'package:flutter/material.dart';
import 'coffee_tools.dart';
import 'dart:math';

class RecommendationsScreen extends StatefulWidget {
  final String selectedDevice;
  final int numberOfCups;
  final Function(String) clearSelectionCallback; // Add this parameter

  RecommendationsScreen({
     this.selectedDevice,
    this.numberOfCups,
     this.clearSelectionCallback, // Add this parameter
  });

  @override
  _RecommendationsScreenState createState() =>
      _RecommendationsScreenState(selectedDevice, numberOfCups);
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  final String selectedDevice;
  final int numberOfCups;
  String recommendedCoffeeText = "";
  String recommendedWaterText ="";

  _RecommendationsScreenState(this.selectedDevice, this.numberOfCups) {
    if (selectedDevice == "French Press") {
      recommendedCoffeeText = "${(numberOfCups * 170.1 / 14).ceil()}g - course ground coffee";
      recommendedWaterText = "${(numberOfCups * 170.1).ceil()}g - water";
    } else if (selectedDevice == "Drip Machine") {
      recommendedCoffeeText = "${(numberOfCups * 170.1 / 17).ceil()}g - medium ground coffee";
      recommendedWaterText = "${(numberOfCups * 170.1).ceil()}g - water";
    }

    // Print debugging information
    print("selectedDevice:$selectedDevice");
    print("numberOfCups:$numberOfCups");
    print("recommendedCoffeeText:$recommendedCoffeeText");
    print("recommendedWaterText:$recommendedWaterText");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recommended Brewing Tips"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xFF4C748B),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Recommended",
                style: TextStyle(
                  fontFamily: 'Kollectif',
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF4C748B),
                ),
              ),
              Divider(
                color: Color(0xFF4C748B),
              ),
              SizedBox(height: 20),
              Text(
  "$recommendedCoffeeText",
  key: ValueKey("recommendedCoffeeText"), // Add a key
  style: TextStyle(
    fontFamily: 'Kollektif',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Color(0xFF4C748B),
  ),
),
Text(
  "$recommendedWaterText",
  key: ValueKey("recommendedWaterText"), // Add a key
  style: TextStyle(
    fontFamily: 'Kollektif',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Color(0xFF4c748B),
  ),
),
              SizedBox(height: 20),
              ElevatedButton(
  onPressed: () {
    // Call the clearSelectionCallback to clear the selection
    if (widget.clearSelectionCallback != null) {
      widget.clearSelectionCallback(selectedDevice);
    }

    // Navigate back to the ChooseDeviceScreen
    Navigator.of(context).pop();
  },
  child: Text("Done"),
),
            ],
          ),
        ),
      ),
    );
  }
}
