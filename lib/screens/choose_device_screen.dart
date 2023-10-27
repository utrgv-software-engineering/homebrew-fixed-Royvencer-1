import 'package:flutter/material.dart';
import 'cups_screens.dart';

class ChooseDeviceScreen extends StatefulWidget {
  final void Function(String) clearSelectionCallback;

  ChooseDeviceScreen({ this.clearSelectionCallback});

  @override
  _ChooseDeviceScreenState createState() => _ChooseDeviceScreenState();
}

class _ChooseDeviceScreenState extends State<ChooseDeviceScreen> {
  String selectedDevice = "";
  bool isContinueButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Your Device"),
        backgroundColor: Colors.blue,
        key: ValueKey('chooseDeviceAppBar'), // Add key to the app bar
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "What coffee maker are you using?",
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Color(0xFF4C748B),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                buildChoice("French Press", 'frenchPressChoice'), // Add keys to choices
                buildChoice("Drip Machine", 'dripMachineChoice'),
              ],
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
  onPressed: isContinueButtonEnabled
    ? () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CupsScreen(
            selectedDevice: selectedDevice, // Pass selectedDevice here
            clearSelectionCallback: clearSelection, // Pass the function reference
          ),
        ),
      );
    }
    : null,
  style: ElevatedButton.styleFrom(
    primary: isContinueButtonEnabled ? Colors.blue : Color(0xFF757474),
    padding: EdgeInsets.symmetric(horizontal: 125, vertical: 16),
    elevation: 4,
    minimumSize: Size(280, 46),
  ),
  child: Text(
    "Continue",
    style: TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  ),
  key: ValueKey('continueButton'), // Add key to the continue button
),
        ],
      ),
    );
  }

  Widget buildChoice(String title, String key) {
    bool isSelected = selectedDevice == title;

    return InkWell(
      onTap: () {
        toggleSelection(title);
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xFF4C748B),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4C748B),
                ),
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Icon(
                  Icons.check,
                  color: Color(0xFF4C748B),
                ),
              ),
          ],
        ),
        key: ValueKey(key), // Add key to the choice container
      ),
    );
  }

  void toggleSelection(String device) {
    setState(() {
      if (selectedDevice == device) {
        selectedDevice = "";
      } else {
        selectedDevice = device;
      }
      updateContinueButtonState();
    });
  }
void clearSelection(String device) {
  setState(() {
    // Clear the selection
    selectedDevice = "";

    // Update the state to disable the "Continue" button
    isContinueButtonEnabled = false;
  });
}
  void updateContinueButtonState() {
    setState(() {
      isContinueButtonEnabled = selectedDevice.isNotEmpty;
    });
  }
}

void main() => runApp(
      MaterialApp(
        home: ChooseDeviceScreen(),
      ),
    );