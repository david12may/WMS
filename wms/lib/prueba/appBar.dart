import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Drawer1 extends StatefulWidget {
  Drawer1({
    Key? key,
  }) : super(key: key);

  @override
  State<Drawer1> createState() => _Drawer1State();
}

// final user = FirebaseAuth.instance.currentUser;

//     final name = user?.displayName;
//     final email = user?.email;
class _Drawer1State extends State<Drawer1> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 100),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            color: Color.fromARGB(255, 43, 51, 122),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    offset: Offset(0, 4),
                    color: Color.fromARGB(255, 226, 224, 224),
                  )
                ], borderRadius: BorderRadius.circular(100)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      "assets/codigo.png",
                    )),
              ),
              // if (name==null) ...[
              Text(
                "Hola, usuario",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
              // ] else ...[
              // Text(
              //           "Hola, ${name!}",
              //           style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.w800,
              //               fontSize: getRelativeWidth(0.04)),
              //         ),
              // ],

              SizedBox(height: 10),
              Text(
                "WMS",
                style: TextStyle(
                  color: Colors.blueGrey[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
