import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fortune_ai_predictor/home.dart';

class ApplePage extends StatefulWidget {
  @override
  _ApplePageState createState() => _ApplePageState();
}

class _ApplePageState extends State<ApplePage> {
  List<String> imagePaths = ['assets/img1.jpg', 'assets/img2.jpg'];
  List<Widget> squares = List.filled(5, Container());
  int clickCount = 0;
  int img2Count = 1;
  List<int> img2Positions = [];
  bool isLoading = false;
  List<double> oddValues = [
    1.23,
    1.54,
    1.93,
    2.41,
    4.02,
    6.71,
    11.18,
    27.97,
    69.93,
    349.68
  ];
  double oddValue = 1.23; // Initialize to the first value in oddValues list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apple Of Fortune', style: TextStyle(color: Colors.white)),
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
                      'Apple predictions (odd: $oddValue)',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    SizedBox(height: 20),
                    FutureBuilder(
                      future: placePicturesRandomly(),
                      builder: (context, snapshot) {
                        return GridView.count(
                          crossAxisCount: 5,
                          shrinkWrap: true,
                          children: List.from(squares),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });

                        Future.delayed(Duration(seconds: 5), () {
                          setState(() {
                            clickCount++;

                            // Calculate the index based on the current clickCount
                            int oddIndex = clickCount % oddValues.length;
                            oddValue = oddValues[oddIndex];

                            if (clickCount == 4 ||
                                clickCount == 7 ||
                                clickCount == 9 ||
                                clickCount == 10) {
                              img2Count++;
                            }

                            placePicturesRandomly();

                            isLoading = false;

                            if (clickCount == 10) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Game Over'),
                                    content: Text(
                                        'You\'ve finished your current game. Do you want to play another game?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            clickCount = 0;
                                            img2Count = 1;
                                            oddValue = oddValues[0];
                                          });
                                          placePicturesRandomly();
                                          Navigator.pop(context);
                                        },
                                        child: Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen()),
                                          );
                                        },
                                        child: Text('No'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          });
                        });
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
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text('Check Apple Place'),
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
                        color: Colors.black, // Change color to red
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
                        color: Color(0xFF2bcca1), // Change color to #2bcca1
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

  Future<void> placePicturesRandomly() async {
    List<Widget> newSquares = [];

    img2Positions.clear();

    for (int i = 0; i < img2Count; i++) {
      int img2Position = Random().nextInt(5);
      while (img2Positions.contains(img2Position)) {
        img2Position = Random().nextInt(5);
      }
      img2Positions.add(img2Position);
    }

    for (int i = 0; i < 5; i++) {
      newSquares.add(Container(
        height: 3.39 * MediaQuery.of(context).size.width / 100,
        width: 3.15 * MediaQuery.of(context).size.width / 100,
        margin: EdgeInsets.all(8),
        color: Colors.white,
        child: Center(
          child: (img2Positions.contains(i))
              ? Image.asset(
                  imagePaths[1],
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  imagePaths[0],
                  fit: BoxFit.cover,
                ),
        ),
      ));
    }

    setState(() {
      squares = newSquares;
    });
  }
}
