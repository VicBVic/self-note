import 'package:flutter/material.dart';
import 'package:itec20222/screens/paper_good.dart';

class DesktopHomeScreen extends StatefulWidget {
  const DesktopHomeScreen({Key? key}) : super(key: key);

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paper Friend'),
        actions: [
          PopupMenuButton<Text>(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(
                    'da',
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: PaperGood(),
    );
  }
}