import 'dart:ui';

import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

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
                            'About my App',
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
                                'Welcome to Melodius, the ultimate destination for music lovers everywhere. Our app is designed to provide you with the best possible music experience, whether youre a casual listener or a die-hard fan.',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text('''Features
- Personalized playlists based on your listening history and preferences
- A huge library of songs and albums, spanning every genre and era
- High-quality audio streaming and downloading, so you can enjoy your music anywhere, anytime
- Exclusive content, including live recordings, behind-the-scenes footage, and artist interviews
- Seamless integration with your favorite music platforms, including Spotify, Apple Music, and YouTube
Our Team:

[Music App Name] was founded by a team of music industry veterans and tech experts, who are passionate about creating the best possible music experience for fans. Meet our team:


Irshad A A, Lead Developer: Student in brototype
Partnerships:

Melodius has formed partnerships with some of the biggest names in music, 


Press:

Melodius has been featured in a variety of music and tech publications, 


Contact:

If you have any questions, comments, or feedback about Melodius, please don't hesitate to get in touch with us. You can reach our support team by emailing irshadabdulla19@gamil.com, or by filling out the contact form on our website.

Legal Information:

For information about our privacy policy, terms of service, and other legal disclaimers, please visit our Legal page.

Social Media:

Follow us on social media to stay up-to-date on news and updates:

https://www.facebook.com/irshad.irshad.100483/
https://www.instagram.com/__i_rsh_ad.__/
https://www.youtube.com/channel/UCpXIcOPJsbRJSzWNRyu8LXA
Of course, the specific content and formatting of an About page will vary depending on the app and the company behind it, but hopefully this example gives you a good idea of what an effective About page could look like.''',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15))
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
