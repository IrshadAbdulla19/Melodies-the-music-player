import 'package:flutter/material.dart';
import 'package:music_player/main.dart';
import 'package:music_player/screens/main_screen.dart';
import 'package:music_player/styles/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartingPage extends StatelessWidget {
  StartingPage({super.key});
  final _usernameControler = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var _mediaQuary = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/images/images (1).jpeg'),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Enter your name',
                      style: mainHead,
                    ),
                  ),
                ],
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
              // SizedBox(
              //   height: _mediaQuary.size.height * 0.3,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: _mediaQuary.size.width * 0.7,
                    height: _mediaQuary.size.height * 0.068,
                    child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            forStart(context);
                          } else {
                            print('error');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 6, 59, 102),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Let's Start",
                              style: TextStyle(fontSize: 17),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                            )
                          ],
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: _mediaQuary.size.width * 0.5,
                    height: _mediaQuary.size.height * 0.068,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (cntx1) {
                            return MainScreen(name: _usernameControler.text);
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 6, 59, 102),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "skip",
                              style: TextStyle(fontSize: 17),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                            )
                          ],
                        )),
                  ),
                ],
              )
            ],
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
