import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';

class studentProvider extends ChangeNotifier{

  List <StudentModel> students = [];

  void addstudent( StudentModel student){
students.add(student);
notifyListeners();
  }

  void editstudent(int index,StudentModel UpdatedStudent){
students[index] = UpdatedStudent;
notifyListeners();
  }

  void deletestudent(int index){
    students.removeAt(index);
    notifyListeners();
  }

  List <StudentModel> searchstudents(String query){
return students.where((student)=> student.name.toLowerCase().contains(query.toLowerCase())).toList();

  }

}