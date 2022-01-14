import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _controller = TextEditingController(); // controller
  static final default_hint = "ทายเลขตั้งแต่ 1 ถึง 100";
  Game _game = Game();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.shade100,
                offset: Offset(5.0, 5.0),
                spreadRadius: 2.0,
                blurRadius: 5.0,
              )
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Row(
                children: [
                  Container(width: 50.0, height: 50.0, color: Colors.blue),
                  Expanded(
                    child: Container(
                      width: 30.0,
                      height: 50.0,
                      //color: Colors.pink,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('FLUTTER', textAlign: TextAlign.end,),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  //SizedBox(width: 10.0),
                ],
              ),*/
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 90.0),
                    SizedBox(width: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start, // ปรับให้ตรงกันชิดซ้าย
                      children: [
                        Text('GUESS',
                            style: TextStyle(
                                fontSize: 36.0, color: Colors.orange.shade200)),
                        Text(
                          'THE NUMBER',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.deepOrange.shade600,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  decoration: InputDecoration(
                      fillColor: Colors.white, filled: true,
                    border: OutlineInputBorder(),
                    hintText: default_hint,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  child: Text('GUESS'),
                  onPressed: () {
                    var input = _controller.text;
                    int input_number;
                    var title = 'RESULT';
                    var content = 'กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาตัวเลขเท่านั้น';
                    try {
                      input_number = int.parse(input);

                      // Do
                      var result = _game.doGuess(input_number);

                      if(result==1){
                        content = '$input_number มากเกินไป กรุณาลองใหม่';
                      } else if(result==-1){
                        content = '$input_number น้อยเกินไป กรุณาลองใหม่';
                      } else {
                        title = 'RESULT';
                        var count = _game.guessCount;
                        content = '$input_number ถูกต้องครับ\nคุณทายทั้งหมด $count ครั้ง';
                        _game = Game();
                      }

                    } catch(e) {
                      title = 'ERROR';
                    }
                    _controller.clear();
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(title),
                          content: Text(content),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
