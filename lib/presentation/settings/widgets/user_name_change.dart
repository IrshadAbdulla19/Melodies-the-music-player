import 'package:flutter/material.dart';
import 'package:music_player/main.dart';

import 'package:music_player/domain/core/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNameChange extends StatefulWidget {
  UserNameChange({
    super.key,
  });

  @override
  State<UserNameChange> createState() => _UserNameChangeState();
}

class _UserNameChangeState extends State<UserNameChange> {
  final _UserNameController = TextEditingController();
  final _userNameKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 14, 13, 31),
        // elevation: 0.0,
        leading: CircleAvatar(
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.keyboard_arrow_down_sharp))),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('asset/images/images (1).jpeg'),
                fit: BoxFit.cover)),
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.only(top: 150, left: 20, right: 20),
          child: Form(
            key: _userNameKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: const EdgeInsets.only(bottom: 40.0, left: 10),
                  child: Text(
                    'Enter your name',
                    style: mainHead,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else {
                      return null;
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  controller: _UserNameController,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color.fromARGB(255, 6, 59, 102),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28))),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28))),
                            child: Text('Cancel')),
                      ),
                      Container(
                        width: 140,
                        height: 40,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_userNameKey.currentState!.validate()) {
                                forStart(context);
                              } else {
                                print('error');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28))),
                            child: Text('Confirm')),
                      ),
                    ],
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
    sharepref.setString(userIn, _UserNameController.text);
    sharepref.setBool(userCheck, true);
    Navigator.pop(context);
  }
}
