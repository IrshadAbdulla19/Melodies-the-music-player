import 'dart:ui';

import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

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
                            'Privacy Policy',
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
                                '''Melodius we operates the Melodius mobile application .

This page informs you of our policies regarding the collection, use, and disclosure of personal data when you use our Service and the choices you have associated with that data.

We use your data to provide and improve the Service. By using the Service, you agree to the collection and use of information in accordance with this policy. Unless otherwise defined in this Privacy Policy, terms used in this Privacy Policy have the same meanings as in our Terms and Conditions.

Information Collection and Use

We collect several different types of information for various purposes to provide and improve our Service to you.

Types of Data Collected

Personal Data

While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you ("Personal Data"). Personally identifiable information may include, but is not limited to:

Email address
First name and last name
Phone number
Address, State, Province, ZIP/Postal code, City
Cookies and Usage Data
Usage Data

We may also collect information on how the Service is accessed and used ("Usage Data"). This Usage Data may include information such as your computer's Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that you visit, the time and date of your visit, the time spent on those pages, unique device identifiers, and other diagnostic data.

Location Data

We may use and store information about your location if you give us permission to do so ("Location Data"). We use this data to provide features of our Service, to improve and customize our Service.

Tracking & Cookies Data

We use cookies and similar tracking technologies to track the activity on our Service and hold certain information.

Examples of Cookies we use:

Session Cookies. We use Session Cookies to operate our Service.
Preference Cookies. We use Preference Cookies to remember your preferences and various settings.
Security Cookies. We use Security Cookies for security purposes.
Use of Data

We use the collected data for various purposes:

To provide and maintain the Service
To notify you about changes to our Service
To allow you to participate in interactive features of our Service
To provide customer care and support
To provide analysis or valuable information so that we can improve the Service
To monitor the usage of the Service
To detect, prevent and address technical issues
Transfer of Data

Your information, including Personal Data, may be transferred to - and maintained on - computers located outside of your state, province, country or other governmental jurisdiction where the data protection laws may differ from those of your jurisdiction.

If you are located outside [Country Name] and choose to provide information to us, please note that we transfer the data, including Personal Data, to [Country Name] and process it there.

Disclosure of Data

We may disclose your Personal Data in the good faith belief that such action is necessary to:

To comply with a legal obligation
To protect and defend the rights or property of  Melodius
To prevent or investigate possible wrongdoing in connection with the Service
To protect the personal safety of users of the Service or the public
To protect against legal liability
Security of Data

The security of your data is important to us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data,''',
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
