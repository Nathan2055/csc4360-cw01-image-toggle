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

void main() {
  runApp(MaterialApp(home: DigitalPetApp()));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = '';
  String petNameTemp = '';
  int happinessLevel = 50;
  int hungerLevel = 50;
  late TextEditingController _controller; // controller for text field
  Timer? _hungerTimer;
  Timer? _winTimer;
  int winReached = 0;

  // Dropdown menu control variables
  final TextEditingController iconController = TextEditingController();
  IconLabel? selectedIcon;

  @override
  void initState() {
    super.initState();

    // Initialize controller for the text field
    _controller = TextEditingController();

    // Start a timer that runs every 30 seconds
    _hungerTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        hungerLevel += 5; // Increase hunger

        // Cap hunger at 100
        if (hungerLevel >= 100) {
          hungerLevel = 100;
        }
      });
    });

    // Start a timer to check for the win state
    _winTimer = Timer.periodic(Duration(seconds: 180), (timer) {
      setState(() {
        if (happinessLevel >= 80) {
          winReached = 1;
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digital Pet')),
      body: Center(child: getInterface()),
    );
  }
}
