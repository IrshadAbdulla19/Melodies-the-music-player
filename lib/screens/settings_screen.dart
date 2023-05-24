import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:music_player/styles/style.dart';

import 'package:music_player/widgets/setting_widg/privacy_and_terms.dart';
import 'package:share_plus/share_plus.dart';

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
                              showAboutDialog(
                                  context: context,
                                  applicationName: "Melodies",
                                  applicationIcon: Image.asset(
                                    "asset/images/logo.png",
                                    height: 32,
                                    width: 32,
                                  ),
                                  applicationVersion: "1.0.1",
                                  children: [
                                    const Text(
                                        "irshadMusic is an offline music player app which allows use to hear music from their local storage and also do functions like add to favorites , create playlists , recently played , mostly played etc."),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text("App developed by Irshad A A.")
                                  ]);
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
                              showDialog(
                                context: context,
                                builder: (context) => privacydialoge(
                                  mdFileName: 'privacy.md',
                                ),
                              );
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
                              showDialog(
                                context: context,
                                builder: (context) => privacydialoge(
                                  mdFileName: 'terms.md',
                                ),
                              );
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
                            onTap: () async {
                              bottomSheet(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [
                                  IconButton(
                                      color: Colors.white,
                                      iconSize: 35,
                                      onPressed: () {},
                                      icon: Icon(Icons.share)),
                                  const Text('For share', style: settingsHeads)
                                ],
                              ),
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: () {
                          //     checkpermission();
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(14.0),
                          //     child: Row(
                          //       children: [
                          //         IconButton(
                          //             color: Colors.white,
                          //             iconSize: 35,
                          //             onPressed: () {},
                          //             icon: Icon(Icons.sync)),
                          //         const Text('For Sync', style: settingsHeads)
                          //       ],
                          //     ),
                          //   ),
                          // ),
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

  Future bottomSheet(
    BuildContext cntx,
  ) async {
    return showModalBottomSheet(
        context: cntx,
        builder: (BuildContext context) {
          const urllink = 'com.melodieuse.music_player';
          Share.share(urllink);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          return Container();
        });
  }
}

// void shareText() async {
//   try {
//     await FlutterShare.share(title: 'check out this flutter app');
//   } catch (e) {
//     print('Sharing failed: $e');
//   }
// }
