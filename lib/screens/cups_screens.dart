import 'package:flutter/material.dart';
import 'package:homebrew/screens/recommendationsScreen.dart';

class CupsScreen extends StatefulWidget {
  final String selectedDevice;
  final void Function(String) clearSelectionCallback;

  CupsScreen({
    this.selectedDevice,
    this.clearSelectionCallback,
  });

  @override
  _CupsScreenState createState() => _CupsScreenState();
}

class _CupsScreenState extends State<CupsScreen> {
  TextEditingController cupsController = TextEditingController();
  bool isContinueButtonEnabled = false; // Initially disabled

  // Function to check if the input is valid
  void checkInputValidity(String text) {
    // Check if the input is a non-empty string and a positive integer
    final isValidInput = (text.isNotEmpty && int.tryParse(text) != null && int.tryParse(text) > 0);

    setState(() {
      isContinueButtonEnabled = isValidInput;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How Many Cups You Would Like?"),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            // Use Navigator to pop the current screen and go back to the previous screen
            Navigator.of(context).pop();
          },
          key: Key('back'), // Adding a key labeled "back" to the back button
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter the number of cups you would like?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Color(0xFF4C748B),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                key: Key('cupsTextField'),
                controller: cupsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Number of cups",
                ),
                onChanged: (text) {
                  // Check the validity of the input and enable/disable the button
                  checkInputValidity(text);
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isContinueButtonEnabled
                  ? () {
                      int numberOfCups = int.tryParse(cupsController.text) ?? 0;
                      // Add your logic here to handle the number of cups

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => RecommendationsScreen(
                            selectedDevice: widget.selectedDevice,
                            numberOfCups: numberOfCups,
                            clearSelectionCallback: widget.clearSelectionCallback,
                          ),
                        ),
                      );
                    }
                  : null, // Disable the button if input is invalid
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}



class ResultScreen extends StatelessWidget {
  final int numberOfCups;

  ResultScreen(this.numberOfCups);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Text(
          "You selected $numberOfCups cups.",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Color(0xFF4C748B),
          ),
        ),
      ),
    );
  }
}