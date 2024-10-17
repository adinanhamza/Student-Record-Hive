import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Details extends StatelessWidget {
   String name;
 
 String age;
 String address;
 dynamic image;

   Details({super.key , required this.image, required this.name,  required this.age, required this.address});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Details'),
          centerTitle: true,
          backgroundColor: Colors.amber[100],
        ),
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     CircleAvatar(
      radius: 80,
      backgroundImage: FileImage(File(image),),

     ),
     SizedBox(
      height: 20,

     ),

     Title(color: Colors.black,
      child: 
      Text('Name : $name',
      style: TextStyle(
        fontSize: 25,
        fontStyle: FontStyle.italic
      ),
      ),
      ),


        Title(color: Colors.black,
      child: 
      Text('Age : $age',
      style: TextStyle(
        fontSize: 25,
        fontStyle: FontStyle.italic
      ),
      ),
      ),

        Title(color: Colors.black,
      child: 
      Text('Adrress : $address',
      style: TextStyle(
        fontSize: 25,
        fontStyle: FontStyle.italic
      ),
      ),
      ),
SizedBox(
  height: 15,
),
      ElevatedButton(onPressed: (){
        Navigator.of(context).pop();
      }, child: 
      Text('Back',
      style: TextStyle(
        color: Colors.black
      ),
      ))
    ],
  ),
),
      ) ,
      );
  }
}