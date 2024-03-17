import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.1),
          child: Icon(Icons.widgets, color: Colors.white),
        ),
      ),
    );
  }
}
