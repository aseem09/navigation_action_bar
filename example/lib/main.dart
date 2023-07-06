import 'package:flutter/material.dart';
import 'package:navigation_action_bar/navigation_action_bar.dart';

void main() => runApp(const MaterialApp(home: CustomNavigationBar()));

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  double currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationActionBar(
        context: context,
        scaffoldColor: Colors.blueAccent,
        index: 0,
        subItems: [
          NavBarItem(iconData: Icons.attach_file, size: 25),
          NavBarItem(iconData: Icons.photo, size: 25),
          NavBarItem(iconData: Icons.camera_alt, size: 25),
        ],
        mainIndex: 2,
        items: [
          NavBarItem(iconData: Icons.list, size: 30),
          NavBarItem(iconData: Icons.compare_arrows, size: 30),
          NavBarItem(iconData: Icons.add, size: 40),
          NavBarItem(iconData: Icons.call_merge, size: 30),
          NavBarItem(iconData: Icons.person, size: 30),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: Container(
        color: Colors.blueAccent,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(
            currentIndex.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
