import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:collection/collection.dart';

void main() {
  runApp(MaterialApp(home: DigitalPetApp()));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

// Define dropdown menu
typedef IconEntry = DropdownMenuEntry<IconLabel>;

enum IconLabel {
  play('Play with Your Pet', Icons.sports_baseball),
  feed('Feed Your Pet', Icons.fastfood);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;

  static final List<IconEntry> entries = UnmodifiableListView<IconEntry>(
    values.map<IconEntry>(
      (IconLabel icon) => IconEntry(
        value: icon,
        label: icon.label,
        leadingIcon: Icon(icon.icon),
      ),
    ),
  );
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

  void _playWithPet() {
    setState(() {
      happinessLevel += 10;
      _updateHunger();
    });
  }

  void _feedPet() {
    setState(() {
      hungerLevel -= 10;
      _updateHappiness();
    });
  }

  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel -= 20;
    } else {
      happinessLevel += 10;
    }
  }

  void _updateHunger() {
    setState(() {
      hungerLevel += 5;
      if (hungerLevel > 100) {
        hungerLevel = 100;
        happinessLevel -= 20;
      }
    });
  }

  void _saveName() {
    setState(() {
      petName = _controller.text;
    });
  }

  // Display colored icon based on inputted happiness value
  Image getMoodIcon(int value) {
    double iconWidth = 200.0; // update icon width globally here

    if (value > 70) {
      return Image.asset('images/dog-icon-green.png', width: iconWidth);
    } else if (value >= 30) {
      return Image.asset('images/dog-icon-yellow.png', width: iconWidth);
    } else if (value >= 1) {
      return Image.asset('images/dog-icon-red.png', width: iconWidth);
    } else {
      return Image.asset('images/dog-icon-black.png', width: iconWidth);
    }
  }

  // Display colored icon based on inputted happiness value
  Text getMoodText(int value) {
    if (value > 70) {
      return Text('Happy', style: TextStyle(fontSize: 15.0));
    } else if (value >= 30) {
      return Text('Neutral', style: TextStyle(fontSize: 15.0));
    } else if (value >= 1) {
      return Text('Unhappy', style: TextStyle(fontSize: 15.0));
    } else {
      return Text('Neutral', style: TextStyle(fontSize: 15.0));
    }
  }

  // Dynamically display query for pet name, win/loss, or main interface
  Container getInterface() {
    // Pet name input interface
    if (petName == '') {
      return Container(
        child: Align(
          alignment: AlignmentGeometry.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(64.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter pet name',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(onPressed: _saveName, child: Text('Save Name')),
              ],
            ),
          ),
        ),
      );
    }
    // Win state
    else if (winReached == 1) {
      return Container(
        child: Align(
          alignment: AlignmentGeometry.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(64.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('You win!', style: TextStyle(fontSize: 20.0)),
              ],
            ),
          ),
        ),
      );
    }
    // Loss state
    else if (hungerLevel >= 100 || happinessLevel <= 10) {
      return Container(
        child: Align(
          alignment: AlignmentGeometry.center,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(64.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Game over!', style: TextStyle(fontSize: 20.0)),
              ],
            ),
          ),
        ),
      );
    }
    // Main interface
    else {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Pet icon and mood text
            getMoodIcon(happinessLevel),
            SizedBox(height: 16.0),
            getMoodText(happinessLevel),
            SizedBox(height: 16.0),

            // Pet stats
            Text('Name: $petName', style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 16.0),
            Text(
              'Happiness Level: $happinessLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),

            // Activities dropdown menu
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownMenu<IconLabel>(
                  controller: iconController,
                  enableFilter: false,
                  requestFocusOnTap: true,
                  leadingIcon: Icon(selectedIcon?.icon),
                  label: const Text('Select Activity'),
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  onSelected: (IconLabel? icon) {
                    setState(() {
                      if (icon?.label == 'Play with Your Pet') {
                        _playWithPet();
                      } else if (icon?.label == 'Feed Your Pet') {
                        _feedPet();
                      }
                    });
                  },
                  dropdownMenuEntries: IconLabel.entries,
                ),
              ],
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digital Pet')),
      body: Center(child: getInterface()),
    );
  }
}
