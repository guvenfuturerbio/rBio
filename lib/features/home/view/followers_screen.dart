import 'package:atom/atom.dart';
import 'package:flutter/material.dart';

import '../widgets/card_widget.dart';

class FollowersScreen extends StatefulWidget {
  FollowersScreen({Key key}) : super(key: key);

  @override
  _FollowersScreenState createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomCard.getImageSquare(
            "assets/images/asd.png",
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Endokronoloji Cüneyt Akın",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Atom.height * 0.07,
            Atom.height * 0.07,
            const Icon(
              Icons.close,
              color: Colors.grey,
              size: 25,
            ),
          ),

          //
          CustomCard.getImageSquare(
            "assets/images/asd.png",
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "İnsan Kaynakları Müdürü",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Atom.height * 0.07,
            Atom.height * 0.07,
            const Icon(
              Icons.close,
              color: Colors.grey,
              size: 25,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        onPressed: () {
          print("Floating Action Button");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
