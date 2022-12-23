import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      //todo change or remove color
      backgroundColor: Colors.amber,
      body: Center(
        child: Stack(
          children: [
            const Text("something"),
            FloatingActionButton(onPressed: () {

            })
          ],
        ),
      )
    );
  }
}