import 'package:chat_menager/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddImageWidgets extends StatefulWidget {
  const AddImageWidgets({Key? key}) : super(key: key);

  @override
  State<AddImageWidgets> createState() => _AddImageWidgetsState();
}

class _AddImageWidgetsState extends State<AddImageWidgets> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            height: 164,
            width: 164,
            decoration: BoxDecoration(
              color: white,
              shape: BoxShape.circle,
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: ClipOval(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 42),
              child: Image.asset("assets/images/camera.png"),
            )),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Container(
              height: 42,
              width: 42,
              decoration: const ShapeDecoration(
                color: customDarkGreen,
                shape: OvalBorder(
                  side: BorderSide(width: 1, color: grey),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/camera.png",
                  color: white,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
