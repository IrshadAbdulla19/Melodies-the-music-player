import 'package:flutter/material.dart';
import 'package:music_player/main.dart';

import 'package:music_player/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingPage extends StatelessWidget {
  StartingPage({super.key});
  final _usernameControler = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/images/images (1).jpeg'),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(top: 70, right: 30, left: 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 10, right: 10, bottom: 15),
                  child: Text(
                    'Enter your name',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'enter your name please';
                    } else {
                      return null;
                    }
                  },
                  controller: _usernameControler,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 6, 59, 102),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 90, left: 90),
                  child: Container(
                    width: 150,
                    height: 55,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            forStart(context);
                          } else {
                            print('error');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28))),
                        child: Text("Let's start")),
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<void> forStart(BuildContext cntx) async {
    final sharepref = await SharedPreferences.getInstance();
    sharepref.setString(userIn, _usernameControler.text);
    sharepref.setBool(userCheck, true);
    Navigator.pushReplacement(cntx, MaterialPageRoute(builder: (cntx1) {
      return MainScreen(name: _usernameControler.text);
    }));
  }
}
