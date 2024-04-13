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
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hola soy Joel"),
            SizedBox(height: 20,),
            ElevatedButton(onPressed:() {
              
            }, child: Text("boton")),

          ],
        ),
      ),

    );
  }
}