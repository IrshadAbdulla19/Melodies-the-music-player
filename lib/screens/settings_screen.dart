import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:music_player/functions/settings_function/for_fetch_songs.dart';
import 'package:music_player/styles/style.dart';
import 'package:music_player/widgets/setting_widg/about_screen.dart';
import 'package:music_player/widgets/setting_widg/prvacy_screen.dart';
import 'package:music_player/widgets/setting_widg/terms_and_condition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/images/images (1).jpeg'),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, left: 40),
                  child: ListView(children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 60,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Settings',
                            style: mainHead,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (cntx) {
                                return AboutScreen();
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [
                                  IconButton(
                                      color: Colors.white,
                                      iconSize: 35,
                                      onPressed: () {},
                                      icon: Icon(Icons.account_circle)),
                                  const Text(
                                    'About',
                                    style: settingsHeads,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (cntx) {
                                return PrivacyScreen();
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [
                                  IconButton(
                                      color: Colors.white,
                                      iconSize: 35,
                                      onPressed: () {},
                                      icon: Icon(Icons.privacy_tip_sharp)),
                                  const Text('Privacy', style: settingsHeads)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (cntx) {
                                return TermsAndCondition();
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [
                                  IconButton(
                                      color: Colors.white,
                                      iconSize: 35,
                                      onPressed: () {},
                                      icon: Icon(Icons.file_copy_outlined)),
                                  const Text('Terms and conditions',
                                      style: settingsHeads)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              checkpermission();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [
                                  IconButton(
                                      color: Colors.white,
                                      iconSize: 35,
                                      onPressed: () {},
                                      icon: Icon(Icons.sync)),
                                  const Text('For Sync', style: settingsHeads)
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              forExit(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [
                                  IconButton(
                                      color: Colors.white,
                                      iconSize: 35,
                                      onPressed: () {},
                                      icon: Icon(Icons.exit_to_app_rounded)),
                                  const Text('Exit app', style: settingsHeads)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            )));
  }

  Future<void> forExit(BuildContext cntx) async {
    final sharepref = await SharedPreferences.getInstance();
    sharepref.clear();
    SystemNavigator.pop();
  }
}
