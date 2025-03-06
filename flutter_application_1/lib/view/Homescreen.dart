import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/functions/list_provider.dart';
import 'package:flutter_application_1/view/addstudent.dart';
import 'package:flutter_application_1/view/editstudent.dart';
import 'package:flutter_application_1/view/loginpage.dart';
import 'package:flutter_application_1/controller/functions/dbfunctions.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:flutter_application_1/view/details.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String search = '';
  List<StudentModel> searched = [];

  void searchListNew() {
    searched = studentlistnotifier.value
        .where((smodel) =>
            smodel.name.toLowerCase().contains(search.toLowerCase())) 
        .toList();
  }

  @override
  Widget build(BuildContext context) {
        
    getallsudents();
    searchListNew();
    final studentprovider = Provider.of<studentProvider>(context);
    final displaylist = search.isNotEmpty ? 
    studentprovider.searchstudents(search)
    : studentprovider.students;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Records',
          style: TextStyle(
            fontStyle: FontStyle.italic
          ),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 166, 104, 237),
          actions: [
            IconButton(
              onPressed: () {
                _logout(context);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    search = value;
                    searchListNew();
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: FloatingActionButton(
                    elevation: 7,
                    tooltip: 'ADD',
                    shape: StadiumBorder(),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => Addstudent()));
                    },
                    backgroundColor: Colors.purple,
                    child: Icon(
                      Icons.add,
                      color: Colors.white70,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStudentList(List<StudentModel> studentList) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final data = studentList[index];
        return Card(
          elevation: 6,
          color: const Color.fromARGB(255, 223, 208, 250),

          child: ListTile(
      
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => Details(
                  image: data.image,
                  name: data.name,
                  age: data.age,
                  address: data.address,
                ),
              ));
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            leading: CircleAvatar(
              backgroundImage: data.image != null && data.image!.isNotEmpty
                  ? FileImage(File(data.image!))
                  : AssetImage('assets/images/default_avatar.png') as ImageProvider,
            ),
            title: Text(
              data.name,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.black,
              ),
            ),
            subtitle: Text(data.age.toString()), // Convert age to string
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => Editstudent(
                        index: index,
                        name: data.name,
                        age: data.age,
                        address: data.address,
                      ),
                    ));
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    deletestudent(index);
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        );
      },
     
      itemCount: studentList.length,
    );
  }

  Future<void> _logout(BuildContext context) async {
    // SharedPreferences sharedpr = await SharedPreferences.getInstance();
    // await sharedpr.remove('isLoggedin');
    SharedPreferences sharedpre = await SharedPreferences.getInstance();
    await sharedpre.remove('isLoggedin');
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => Loginpage()));
  }
}
