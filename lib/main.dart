import 'package:flutter/material.dart';
//import 'dart:async';
//import 'dart:math';
//import 'package:collection/collection.dart';

// Main method
void main() {
  runApp(myApp());
}

// App constructor
class myApp extends StatefulWidget {
  const myApp({super.key});

  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  // Theme control variables
  ThemeMode _themeMode = ThemeMode.light;
  bool darkMode = false;

  // Counter variable
  int counterCount = 0;

  // State constructor
  @override
  void initState() {
    super.initState();
  }

  // State destructor
  @override
  void dispose() {
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      counterCount += 1;
    });
  }

  // Interface constructor
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Theme settings
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,

      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('My App'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
          ),
          body: Center(child: TabBarView(children: [homeTab(), settingsTab()])),
        ),
      ),
    );
  }

  // Tab for Part 1: Counter
  Column homeTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'You have pushed the button this many times:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8.0),
        Text('$counterCount', style: TextStyle(fontSize: 20.0)),
        SizedBox(height: 8.0),
        ElevatedButton(onPressed: _incrementCounter, child: Text('Click Here')),
      ],
    );
  }

  // Settings tab
  Column settingsTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Theme control
        Text('Switch Theme', style: TextStyle(fontSize: 18)),
        Switch(
          // switch on == dark mode on
          value: darkMode,
          onChanged: (value) {
            setState(() {
              // if on, switch to light mode; if off, switch to dark mode
              _themeMode = darkMode ? ThemeMode.light : ThemeMode.dark;
              darkMode = !darkMode;
            });
          },
        ),
      ],
    );
  }
}
