import 'package:flutter/material.dart';
import 'package:flutter_application_1/Homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _Loginpage2State();
}

class _Loginpage2State extends State<Loginpage> {
  final _usernamecontroll = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool isLoggedin = false;
  // int pass = 4557;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown[100],
       
        body: Center(
          child: Card(
            elevation: 10,
            color: Colors.amber[100],
            // shadowColor: Colors.blue,
            child: Container(
              height: 500,
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'User Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    TextField(
                      controller: _usernamecontroll,
                      decoration: InputDecoration(
                        labelText: "username",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15),
                            right: Radius.circular(15),
                          ),
                          borderSide: BorderSide(style: BorderStyle.solid),
                        ),
                      ),
                      autofocus: true,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
                      controller: _passwordcontroller,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'password',
                        // hintText: "minimum six letters",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15),
                            right: Radius.circular(15),
                          ),
                          borderSide: BorderSide(style: BorderStyle.solid),
                        ),
                      ),
                      autofocus: true,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _login();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown),
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                      autofocus: true,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Dont`you have an account? Sign Up here! ',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    String username = _usernamecontroll.text.trim();
    String password = _passwordcontroller.text.trim();

    

    SharedPreferences sharedpre = await SharedPreferences.getInstance();

    if(username == 'adinanhamza' && password == 'password'){
      sharedpre.setBool('isLoggedin', true);
       ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Sucessful')));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => Loginpage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ivalid username or password'),
        ),
      );
    }
  }

  Future<void> _checkLoginStatus() async {
    
    SharedPreferences sharedpre = await SharedPreferences.getInstance();

    bool ? isLoggedin = sharedpre.getBool('isLoggedin');
    if(isLoggedin == true){
       Navigator.of(context)
           .pushReplacement(MaterialPageRoute(builder: (ctx) => Homescreen()));
    }
  }
}
