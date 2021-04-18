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
              boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 2.0)],
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey[800],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Center(
                    child: Container(
                      width: 200,
                      height: 150,
                      child: Icon(
                        Icons.pets,
                        color: Colors.grey[200],
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
                      hintText: 'Enter valid email id as abc@gmail.com',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  child: TextButton(
                    onPressed: () {},
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.orangeAccent[600], fontSize: 15),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //print("click");
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).accentColor.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 0),
                        ),
                      ],
                      color: Theme.of(context).accentColor,
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                Text('New User? Create Account'),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
