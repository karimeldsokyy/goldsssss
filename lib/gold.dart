import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'home.dart'; // Import your home.dart file

class GoldPage extends StatefulWidget {
  @override
  _GoldPageState createState() => _GoldPageState();
}

class _GoldPageState extends State<GoldPage> {
  List<String> imagePaths = ['assets/golds.jpg', 'assets/boom.jpg'];
  bool isLoading = false;
  Random random = Random();
  List<int> oddNumbers = [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024];
  int currentOddIndex = 0;

  Future<void> showGameOverDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'You\'ve finished your current game. Do you want to play another game?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                resetPredictions();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to home.dart
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void changeImagesWithDelay() {
    setState(() {
      isLoading = true;
    });
    Timer(Duration(seconds: 5), () {
      setState(() {
        if (currentOddIndex < oddNumbers.length - 1) {
          imagePaths.shuffle();
          currentOddIndex++;
        } else {
          showGameOverDialog();
        }
        isLoading = false;
      });
    });
  }

  void resetPredictions() {
    setState(() {
      currentOddIndex = 0;
      // Reset other prediction-related variables here if needed
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wild West Gold', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 70.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            'assets/aipredictor.png',
                            height: 170.0,
                            width: 310.0,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Golds predictions (odd is: ${oddNumbers[currentOddIndex]})',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 100,
                            width: 150,
                            margin: EdgeInsets.all(8),
                            color: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                imagePaths[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 100,
                            width: 150,
                            margin: EdgeInsets.all(8),
                            color: Colors.white,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                imagePaths[1],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        changeImagesWithDelay();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(179, 0, 106, 187),
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Check Gold Place'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Sponsored ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: 'by ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                    TextSpan(
                      text: 'ChatGPT',
                      style: TextStyle(
                        color: Color(0xFF2bcca1),
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
