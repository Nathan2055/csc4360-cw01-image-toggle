import 'package:flutter/material.dart';

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

  Color lightModeBackground = Colors.blueGrey;
  Color darkModeBackground = Colors.black;

  Color lightModeShape = Colors.grey;
  Color darkModeShape = Colors.white;

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
            color: darkMode ? darkModeBackground : lightModeBackground,

            child: TabBarView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Mobile App Development Testing',
                      style: TextStyle(fontSize: 18),
                    ),

                    // add some extra spacing
                    Text(' ', style: TextStyle(fontSize: 9)),

                    PhysicalShape(
                      elevation: 5.0,
                      clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      color: darkMode ? darkModeShape : lightModeShape,
                      child: const SizedBox(
                        height: 100.0,
                        width: 300.0,
                        child: Center(
                          child: Text(
                            'Mobile App Development Testing',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
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
