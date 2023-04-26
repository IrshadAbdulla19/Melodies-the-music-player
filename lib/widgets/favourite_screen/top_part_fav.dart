import 'package:flutter/material.dart';

class TopPartFavourite extends StatelessWidget {
  const TopPartFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
}
