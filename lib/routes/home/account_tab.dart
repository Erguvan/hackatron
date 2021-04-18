import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:putty/widgets/custombody.dart';

class SignInGoogle extends StatefulWidget {
  @override
  State createState() => SignInState();
}

class SignInState extends State<SignInGoogle> {
  String _contactText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: BaseBodyLayout(
            asset: 'assets/backpattern.jpg',
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 1),
                        blurRadius: 2.0)
                  ],
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.grey,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: Container(
                          width: 200,
                          height: 150,
                          child: Icon(
                            Icons.pets,
                            color: Colors.black87,
                            size: 72.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter valid email id as abc@gmail.com'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter secure password'),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Colors.orangeAccent[600], fontSize: 15),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.orange[800],
                          borderRadius: BorderRadius.circular(20)),
                      // ignore: deprecated_member_use
                      child: FlatButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context, MaterialPageRoute(builder: (_) => HomePage()));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('New User? Create Account')
                  ],
                ),
              ),
            )));
  }
}
