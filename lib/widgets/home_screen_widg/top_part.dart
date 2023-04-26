import 'package:flutter/material.dart';
import 'package:music_player/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopPart extends StatefulWidget {
  TopPart({super.key});

  @override
  State<TopPart> createState() => _TopPartState();
}

class _TopPartState extends State<TopPart> {
  String username = '';
  @override
  void initState() {
    userGet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              'Hey $username',
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Dongle',
                  color: Colors.white),
            ),
          ),
          Row(
            children: [
              Expanded(
                  flex: 4,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(255, 6, 59, 102),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(28))),
                  )),
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> userGet() async {
    final pref = await SharedPreferences.getInstance();
    final name = pref.getString(userIn) ?? '';
    username = name;
    setState(() {});
  }
}
