import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Homescreen.dart';
import 'package:flutter_application_1/model/functions/functions.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:image_picker/image_picker.dart';

class Addstudent extends StatefulWidget {
  const Addstudent({super.key});

  @override
  State<Addstudent> createState() => _AddstudentState();
}

class _AddstudentState extends State<Addstudent> {
  File? selectedImage; 

  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController clascontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: colors,,
        appBar: AppBar(
          title: 
          Text('Foarm',
          style: TextStyle(
            fontStyle: FontStyle.italic
          ),),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(193, 225, 173, 83),
    
      ),
      body: Center(
        
        child: Card(
          elevation: 9,
          child: Container(
            height: double.infinity,
            color: const Color.fromARGB(255, 238, 230, 196),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                    CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color.fromARGB(255, 229, 202, 154),
                          backgroundImage: selectedImage != null
                              ? FileImage(selectedImage!) 
                              : null, 
                          child: selectedImage == null
                              ? Padding(
                                  padding: EdgeInsets.all(9),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                )
                              : null, 
                        ),
                      
                      SizedBox(height: 5),
                      
                        TextButton(
                        style: TextButton.styleFrom(
                           backgroundColor: const Color.fromARGB(63, 225, 210, 182),
                          foregroundColor: const Color.fromARGB(167, 0, 0, 0)

                        ),
                          onPressed: (){
                      
                      pickGalleryImage();
                     }, child: 
                     Text('Add Image'),
                     ),
                      TextField(
                      
                        controller: namecontroller,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          style: BorderStyle.solid
                        )
                          )
                        ),
                      ),
                  
                      SizedBox(
                        height: 15,
                      ),
                       TextField(
                      
                        controller: agecontroller,
                        decoration: InputDecoration(
                          labelText: 'Age',
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          style: BorderStyle.solid
                        )
                          )
                        ),
                      ),
                           SizedBox(
                        height: 15,
                      ),
                       TextField(
                      
                        controller: addresscontroller,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          style: BorderStyle.solid
                        )
                          )
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                        ElevatedButton.icon(
                onPressed: () {
              add();
                },
                icon: Icon(Icons.add,
                
                ),
                label: Text(
                'Add',
                style: TextStyle(
                  color: const Color.fromARGB(193, 0, 0, 0)
                ),
              ),
              ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }

  // Gallery picker
  Future<void> pickGalleryImage() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;

    setState(() {
      selectedImage = File(returnImage.path); 
    });
   
  }


  

  Future add() async {
     namecontroller.text.trim();
    agecontroller.text.toString();
  
  
    addresscontroller.text.trim();
    

    if (namecontroller.text.isEmpty ||  agecontroller.text.isEmpty || addresscontroller.text.isEmpty ) {
      return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          backgroundColor: Colors.red,
          content: Text('invalid format or fill the form')));
    }
    // print('$name $age  $address');

     final studentdata = StudentModel(name: namecontroller.text, age: agecontroller.text,address: addresscontroller.text,image: selectedImage?.path?? ' ');

    studentadd(studentdata);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Homescreen()));
  }
}