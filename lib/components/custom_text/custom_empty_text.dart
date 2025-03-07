
import 'package:flutter/material.dart';

class CustomEmptyPage extends StatefulWidget {
  final bool showText;

  const CustomEmptyPage({super.key, this.showText = true});

  @override
  State<CustomEmptyPage> createState() => _CustomEmptyPageState();
}

class _CustomEmptyPageState extends State<CustomEmptyPage> {
  @override
  Widget build(BuildContext context) {
   
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "empty_page",
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
