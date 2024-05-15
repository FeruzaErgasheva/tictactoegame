import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohTurn = true; //first player is ohTurn
  List<String> displayStringExOh = ["", "", "", "", "", "", "", "", ""];
  int xScore = 0;
  int oScore = 0;
  int filledBOxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Player X:\n$xScore",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Text(
                    "Player O:\n$oScore",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _boxTapped(index),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade700)),
                    child: Center(
                      child: Text(
                        displayStringExOh[index],
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              child: Center(
                child: OutlinedButton(
                  onPressed: _reset,
                  child: Text(
                    "Reset game",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _reset() {
    xScore = 0;
    oScore = 0;
    setState(() {});
  }

  void _boxTapped(int index) {
    setState(() {
      if (ohTurn && displayStringExOh[index] == "") {
        displayStringExOh[index] = "o";
        filledBOxes += 1;
        ohTurn = !ohTurn;
      } else if (!ohTurn && displayStringExOh[index] == "") {
        displayStringExOh[index] = "x";
        ohTurn = !ohTurn;
        filledBOxes += 1;
      }
      // ohTurn = !ohTurn;
      _checkWinner(); //to check each time
    });
  }

  //to check winner
  void _checkWinner() {
    //1st column
    if (displayStringExOh[0] == displayStringExOh[1] &&
        displayStringExOh[1] == displayStringExOh[2] &&
        displayStringExOh[0] != "") {
      _showDialog(displayStringExOh[0]);
    }
    //second column
    if (displayStringExOh[3] == displayStringExOh[4] &&
        displayStringExOh[4] == displayStringExOh[5] &&
        displayStringExOh[3] != "") {
      _showDialog(displayStringExOh[3]);
    }
    //third column
    if (displayStringExOh[6] == displayStringExOh[7] &&
        displayStringExOh[7] == displayStringExOh[8] &&
        displayStringExOh[6] != "") {
      _showDialog(displayStringExOh[6]);
    }
    //diagonal1
    if (displayStringExOh[0] == displayStringExOh[4] &&
        displayStringExOh[4] == displayStringExOh[8] &&
        displayStringExOh[0] != "") {
      _showDialog(displayStringExOh[0]);
    }
    //diagonal 2
    if (displayStringExOh[2] == displayStringExOh[4] &&
        displayStringExOh[4] == displayStringExOh[6] &&
        displayStringExOh[2] != "") {
      _showDialog(displayStringExOh[2]);
    } else if (filledBOxes == 9) {
      _showEqualDialog();
    }
  }

  void _showEqualDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Nobody won"),
          actions: [
            TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text("Play again"))
          ],
        );
      },
    );
  }

  //to show dialoh if sb wins
  void _showDialog(String winner) {
    // String winner = ohTurn ? "x" : "o";
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Winner is $winner"),
          actions: [
            TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text("Play again"))
          ],
        );
      },
    );
    if (winner == "o") {
      oScore += 1;
    } else {
      xScore += 1;
    }
  }

  void _clearBoard() {
    for (int i = 0; i < displayStringExOh.length; i++) {
      displayStringExOh[i] = "";
      setState(() {});
    }
    filledBOxes = 0;
  }
}
