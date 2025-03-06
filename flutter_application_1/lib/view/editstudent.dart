import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/Homescreen.dart';
import 'package:flutter_application_1/controller/functions/dbfunctions.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:image_picker/image_picker.dart';

class Editstudent extends StatefulWidget {
  final int  index;
  final String name;
  final String age;
  final String address;
  const Editstudent({super.key, required this.index,required this.name,required this.age,required this.address});

  @override
  State<Editstudent> createState() => _EditstudentState();
}

class _EditstudentState extends State<Editstudent> {
  File? selectedImage; 

  
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController clascontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: 
          Text('Add New'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
    
      ),
      body: Center(
        
        child: Card(
          elevation: 9,
          child: Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
      
                children: [
                    CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color.fromARGB(255, 241, 246, 100),
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
                      
                        TextButton(onPressed: (){
                      
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
                icon: Icon(Icons.add),
                label: Text(
                'Add'
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
    final studentpro = 
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

   studentedit(widget.index,studentdata);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Homescreen()));
  }
}