import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:hive_flutter/adapters.dart';

ValueNotifier<List<StudentModel>> studentlistnotifier = ValueNotifier([]);


Future <void> studentadd(StudentModel student)async{
  final sbox = await Hive.openBox<StudentModel>('studentdatabase');
  await sbox.add(student);
  getallsudents();
}


Future <void> getallsudents()async{
  final sbox = await Hive.openBox<StudentModel>('studentdatabase');
  studentlistnotifier.value.clear();
  studentlistnotifier.value.addAll(sbox.values);
  studentlistnotifier.notifyListeners();
}


Future <void> deletestudent(int index)async{
  final sbox = await Hive.openBox<StudentModel>('studentdatabase');
  await sbox.deleteAt(index);
  getallsudents();
}


Future <void> studentedit(int index,StudentModel value)async{
  final sbox = await Hive.openBox<StudentModel>('studentdatabase');
  await sbox.putAt(index, value);
}

