import 'dart:ui';

import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('asset/images/images (1).jpeg'),
                    fit: BoxFit.cover)),
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0),
                          child: Text(
                            'Terms and conditions',
                            style: TextStyle(
                                fontSize: 55,
                                color: Colors.white,
                                fontFamily: 'Dongle',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ListView(
                            children: [
                              Text(
                                '''User eligibility: Users must be at least 13 years old to use the app.

User conduct: Users must use the app in a responsible and respectful manner and may not use the app to upload or share any illegal or infringing content.

User-generated content: Users own the content they upload to the app but grant the app a license to use, display, and distribute the content. Users must ensure that they have the necessary rights to upload the content and that it does not violate any third-party rights.

Intellectual property rights: All content on the app, including music, lyrics, and artwork, is owned by the app or its licensors. Users may use the content only for personal, non-commercial use and must obtain permission from the app or the copyright holder to use the content in any other way.

Privacy policy: The app collects and uses personal information in accordance with its privacy policy, which can be accessed on the app or the app's website.

Fees and payment: The app is free to use and does not require any payment.

Termination and suspension: The app may terminate or suspend a user's account for any reason, including violating the terms and conditions or engaging in fraudulent or illegal activity. The app may also delete any content uploaded by the user. Users may terminate their account at any time by contacting customer support.

Disclaimers and limitations of liability: The app provides the service "as is" and does not guarantee that it will be uninterrupted or error-free. The app is not liable for any direct, indirect, incidental, or consequential damages arising from the use of the app or its content.

Changes to terms and conditions: The app reserves the right to modify or update the terms and conditions at any time, and users will be notified of any changes via email or on the app. Users are responsible for reviewing the updated terms and conditions and continuing to use the app constitutes acceptance of the changes.''',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
