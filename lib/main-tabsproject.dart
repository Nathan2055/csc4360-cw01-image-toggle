import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(length: 3, child: _TabsNonScrollableDemo()),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For the ToDo task hint: consider defining the widget and name of the tabs here
    final tabContents = [
      Expanded(
        child: Column(
          children: [
            // spacing
            Text('', style: TextStyle(fontSize: 12)),
            Text('Mobile App Development', style: TextStyle(fontSize: 25)),
            ElevatedButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('AlertDialog Title'),
                  content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: Text('Show Dialog'),
            ),
          ],
        ),
      ),
      Expanded(
        child: Center(
          child: Image.network(
            'https://nathan2055.com/images/NathanLarsen-2023-750px.jpg',
            width: 750,
            height: 750,
          ),
        ),
      ),
      Expanded(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Button pressed in third tab!')),
              );
            },
            child: Text('Click me'),
          ),
        ),
      ),
      Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: false,
          padding: const EdgeInsets.all(8),
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.file_present),
                title: Text('Item 1'),
                subtitle: Text('Item 1'),
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.folder_shared),
                    title: Text('Item 2'),
                    subtitle: Text('Item 2'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];

    final tabNames = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Tabs Demo'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [for (final tab in tabNames) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // hint for the to do task:Considering creating the different for different tabs
          for (final tab in tabContents) Column(children: [tab]),
        ],
      ),
    );
  }
}
