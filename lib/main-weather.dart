import 'package:flutter/material.dart';
import 'dart:math';

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

  bool displayWeather = false;
  bool displayForecast = false;

  // create one randomly generated weather card
  Card generateWeatherCard() {
    // generate random values
    Random rng = Random();
    int conditionInt = rng.nextInt(3) + 1; // value between 1 and 3
    int temperatureInt = rng.nextInt(15) + 15; // value between 15 and 30

    // parse condition out to icon and text
    Icon conditionIcon = Icon(Icons.file_present);
    Text conditionText = Text('Placeholder');
    switch (conditionInt) {
      case 1:
        conditionIcon = Icon(Icons.sunny);
        conditionText = Text('Sunny');
      case 2:
        conditionIcon = Icon(Icons.cloud);
        conditionText = Text('Cloudy');
      case 3:
        conditionIcon = Icon(
          Icons.cloudy_snowing,
        ); // as close to rain as they have in Material icons, apparently
        conditionText = Text('Rainy');
    }

    // construct String and Text from temperature data
    Text temperatureText = Text('$temperatureInt° C');

    // assemble and return card
    return Card(
      child: ListTile(
        leading: conditionIcon,
        title: temperatureText,
        subtitle: conditionText,
      ),
    );
  }

  // create a ListView with one card to represent the current weather
  ListView generateWeather() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return generateWeatherCard();
      },
    );
  }

  // create a ListView with the given number of cards for the forecast
  ListView generateForecast(int days) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: days,
      itemBuilder: (BuildContext context, int index) {
        return generateWeatherCard();
      },
    );
  }

  // quick and dirty vertical spacer
  Text spacer() {
    return Text('', style: TextStyle(fontSize: 12));
  }

  // element constructors because the code got messy

  // create a text field to enter a city
  TextField constructTextField() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter City',
      ),
    );
  }

  // create the button to display the current weather
  ElevatedButton constructWeatherButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          displayWeather = true;
        });
      },
      child: Text('Get Weather'),
    );
  }

  // create the button to display the seven-day forecast
  ElevatedButton constructForecastButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          displayForecast = true;
        });
      },
      child: Text('Get Forecast'),
    );
  }

  // main interface code
  @override
  Widget build(BuildContext context) {
    // create and populate variables containing the weather and forecast
    ListView weather = generateWeather();
    ListView forecast = generateForecast(7);

    return MaterialApp(
      // use system-defined light and dark themes
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),

      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,

      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          // title bar
          appBar: AppBar(
            title: Text('Weather App Demo'),
            bottom: const TabBar(
              tabs: [
                // define tab icons here
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.calendar_month)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
          ),

          // define tab bodies here
          body: TabBarView(
            children: [
              // home/current weather tab
              Column(
                children: [
                  spacer(),

                  // header
                  Text('Current Weather', style: TextStyle(fontSize: 25)),
                  spacer(),

                  // input row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 25.0,
                    children: [
                      Container(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 25.0,
                          children: [
                            Expanded(child: constructTextField()),
                            Expanded(child: constructWeatherButton()),
                          ],
                        ),
                      ),
                      Container(),
                    ],
                  ),

                  spacer(),

                  // info row; display after button is clicked
                  displayWeather ? Expanded(child: weather) : Container(),
                ],
              ),

              // seven-day forecast tab
              Column(
                children: [
                  spacer(),

                  // header
                  Text('Seven-Day Forecast', style: TextStyle(fontSize: 25)),
                  spacer(),

                  // input row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 25.0,
                    children: [
                      Container(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 25.0,
                          children: [
                            Expanded(child: constructTextField()),
                            Expanded(child: constructForecastButton()),
                          ],
                        ),
                      ),
                      Container(),
                    ],
                  ),

                  spacer(),

                  // info row; display after button is clicked
                  displayForecast ? Expanded(child: forecast) : Container(),
                ],
              ),

              // settings tab
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Enable Dark Mode', style: TextStyle(fontSize: 18)),
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
    );
  }
}
