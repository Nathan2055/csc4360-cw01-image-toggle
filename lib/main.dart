import 'package:flutter/material.dart';

// Main method
void main() {
  runApp(const MyApp());
}

// App constructor
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  // Theme control variables
  ThemeMode _themeMode = ThemeMode.light;
  bool darkMode = false;

  // Counter variable
  int counterCount = 0;

  // Image toggle variable
  bool toggleImageState = false;

  // Animation variables
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
      _themeMode = darkMode ? ThemeMode.light : ThemeMode.dark;
      darkMode = !darkMode;
    });
  }

  // Toggle the displayed image on the image toggle interface tab
  void _toggleImage() {
    setState(() {
      toggleImageState = !toggleImageState;
      _controller.reset();
      _controller.forward();
    });
  }

  // Get the currently selected image
  Widget getImage() {
    double scaleFactor = 2.5;
    double imageWidth = 500.0 / scaleFactor;
    double imageHeight = 600.0 / scaleFactor;

    return FadeTransition(
      opacity: _animation,
      child: Image.asset(
        toggleImageState
            ? 'images/dog-500x600.jpg'
            : 'images/cat-500x600.jpg',
        width: imageWidth,
        height: imageHeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('My App')),
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
        const Text(
          'You have pushed the button this many times:',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 8.0),
        Text('$counterCount', style: const TextStyle(fontSize: 20.0)),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text('Push The Button!'),
        ),
        const SizedBox(height: 8.0),

        // Part 2: Image Toggle
        getImage(),
        const SizedBox(height: 8.0),
        ElevatedButton(onPressed: _toggleImage, child: const Text('Switch Image')),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: _changeTheme,
          child: const Text('Switch App Theme'),
        ),
      ],
    );
  }
}
