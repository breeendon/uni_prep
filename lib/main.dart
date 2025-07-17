import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/scores_page.dart';
import 'widgets/college_list.dart';

var icon = Icons.visibility;

final usernameController = TextEditingController();
final passwordController = TextEditingController();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final List<String> userColleges = [];

  void addCollege(String college) {
    if (!userColleges.contains(college)) {
      userColleges.add(college);
      notifyListeners();
    }
  }

  void removeCollege(String college) {
    userColleges.remove(college);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = const ScoresPage();
      case 1:
        page = const PracticePage();
      case 2:
        page = const CollegeList();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 601,
                destinations: const [
                  NavigationRailDestination(
                    icon: Icon(Icons.school),
                    label: Text('AP Score Center'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.fitness_center),
                    label: Text('Practice'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.show_chart_sharp),
                    label: Text('17 reaches'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ignore: must_be_immutable

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('we working on it'),
    );
  }
}
