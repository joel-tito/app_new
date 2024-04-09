import 'package:flutter/material.dart';

class pageOne extends StatefulWidget{
  @override
  pageOneState createState() => pageOneState();
}

class pageOneState extends State<pageOne>{
  //@override
  //void initState(){
    //super.initState();
  //}


  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Titulo")
          ],
        ),
      ),

    );
  }
}