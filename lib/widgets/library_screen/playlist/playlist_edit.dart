import 'package:flutter/material.dart';

class PlaylistRename extends StatelessWidget {
  PlaylistRename({super.key});
  final _playlistNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0, left: 10),
                child: Text(
                  'Rename your playlist',
                  style: TextStyle(
                      fontSize: 55,
                      color: Colors.white,
                      fontFamily: 'Dongle',
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _playlistNameController,
                decoration: InputDecoration(
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28))),
                          child: Text('Reset')),
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
