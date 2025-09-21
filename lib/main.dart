import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:collection/collection.dart';

void main() {
  runApp(RunMyApp());
}

class RunMyApp extends StatefulWidget {
  const RunMyApp({super.key});

  @override
  State<RunMyApp> createState() => _RunMyAppState();
}

class _RunMyAppState extends State<RunMyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  bool darkMode = false;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,

      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Theme Demo'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
          ),

          body: AnimatedContainer(
            duration: Duration(milliseconds: 500),

            child: TabBarView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mobile App Development Testing',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Switch Theme', style: TextStyle(fontSize: 18)),
                    Switch(
                      // switch on == dark mode on
                      value: darkMode,
                      onChanged: (value) {
                        setState(() {
                          // if on, switch to light mode; if off, switch to dark mode
                          _themeMode = darkMode
                              ? ThemeMode.light
                              : ThemeMode.dark;
                          darkMode = !darkMode;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Main method
void main() {
  runApp(MaterialApp(home: myApp()));
}

// App constructor
class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  // Theme control variables
  ThemeMode _themeMode = ThemeMode.light;
  bool darkMode = false;

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

  // Interface constructor
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.home)),
            Tab(icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: Center(child: getMainInterface()),
    );
  }

  // Main app interface
  TabBarView getMainInterface() {
    return TabBarView(children: [homeTab(), settingsTab()]);
  }

  Column homeTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Mobile App Development Testing', style: TextStyle(fontSize: 18)),
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
