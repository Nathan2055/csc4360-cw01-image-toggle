import 'package:flutter/material.dart';

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

  // Image toggle variable
  bool toggleImageState = false;

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

  // Increment the counter by one
  void _incrementCounter() {
    setState(() {
      counterCount += 1;
    });
  }

  // Toggle the current app theme
  void _changeTheme() {
    setState(() {
      // if on, switch to light mode; if off, switch to dark mode
      _themeMode = darkMode ? ThemeMode.light : ThemeMode.dark;
      darkMode = !darkMode;
    });
  }

  // Toggle the displayed image on the image toggle interface tab
  void _toggleImage() {
    setState(() {
      toggleImageState = !toggleImageState;
    });
  }

  // Get the currently selected image
  Image getImage() {
    double scaleFactor = 2.5; // resize images down by this factor
    double imageWidth = 500.0 / scaleFactor;
    double imageHeight = 600.0 / scaleFactor;

    if (toggleImageState) {
      return Image.asset(
        'images/dog-500x600.jpg',
        width: imageWidth,
        height: imageHeight,
      );
    } else {
      return Image.asset(
        'images/cat-500x600.jpg',
        width: imageWidth,
        height: imageHeight,
      );
    }
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

      home: Scaffold(
        appBar: AppBar(title: Text('My App')),
        body: Center(child: homeTab()),
      ),
    );
  }

  // Main interface
  Column homeTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Part 1: Counter
        Text(
          'You have pushed the button this many times:',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8.0),
        Text('$counterCount', style: TextStyle(fontSize: 20.0)),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: Text('Push The Button!'),
        ),
        SizedBox(height: 8.0),

        // Part 2: Image Toggle
        getImage(),
        SizedBox(height: 8.0),
        ElevatedButton(onPressed: _toggleImage, child: Text('Switch Image')),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: _changeTheme,
          child: Text('Switch App Theme'),
        ),
      ],
    );
  }
}
