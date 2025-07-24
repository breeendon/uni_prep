import 'package:flutter/material.dart';
import 'package:http/browser_client.dart';
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
        title: 'AP College Planner',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          scaffoldBackgroundColor: Colors.grey[50],
          cardTheme: CardThemeData(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            elevation: 2,
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final List<String> userColleges = [];
  final Map<String, int> apScores = {};

  void addApScore(String exam, int score) {
    apScores[exam] = score;
    notifyListeners();
  }

  void removeApScore(String exam) {
    apScores.remove(exam);
    notifyListeners();
  }

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
    String title;
    IconData icon;
    switch (selectedIndex) {
      case 0:
        page = const ScoresPage();
        title = "AP Score Center";
        icon = Icons.school;
        break;
      case 1:
        page = const PracticePage();
        title = "Practice";
        icon = Icons.fitness_center;
        break;
      case 2:
        page = const CollegeList();
        title = "My College List";
        icon = Icons.show_chart_sharp;
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          centerTitle: false,
        ),
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth >= 700,
                backgroundColor: Colors.white,
                selectedIconTheme:
                    IconThemeData(color: Colors.deepOrange, size: 32),
                unselectedIconTheme: IconThemeData(color: Colors.grey[600]),
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
                    label: Text('Colleges'),
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
                color: Theme.of(context).scaffoldBackgroundColor,
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

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  int? _selectedIndex;
  bool _answered = false;

  final String question =
      '“Lines Written in Early Spring” is a 1798 poem by William Wordsworth. In the poem, the speaker describes having contradictory feelings while experiencing the sights and sounds of a spring day: ______blank\n\nWhich quotation from “Lines Written in Early Spring” most effectively illustrates the claim?';

  final List<String> choices = [
    '“Through primrose-tufts, in that sweet bower, / The periwinkle trail’d its wreathes; / And ’tis my faith that every flower / Enjoys the air it breathes.”',
    '“The budding twigs spread out their fan, / To catch the breezy air; / And I must think, do all I can, / That there was pleasure there.”',
    '“The birds around me hopp’d and play’d: / Their thoughts I cannot measure, / But the least motion which they made, / It seem’d a thrill of pleasure.”',
    '“I heard a thousand blended notes, / While in a grove I [sat] reclined, / In that sweet mood when pleasant thoughts / Bring sad thoughts to the mind.”',
  ];

  final int correctIndex = 3;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Card(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 28.0, vertical: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb,
                        color: theme.colorScheme.primary, size: 32),
                    const SizedBox(width: 12),
                    Text(
                      'SAT Question of the Day',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  question,
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 17),
                ),
                const SizedBox(height: 32),
                ...List.generate(choices.length, (i) {
                  final isSelected = _selectedIndex == i;
                  final isCorrect = _answered && i == correctIndex;
                  final isWrong = _answered && isSelected && i != correctIndex;
                  Color? tileColor;
                  if (isCorrect) tileColor = Colors.green.withOpacity(0.15);
                  if (isWrong) tileColor = Colors.red.withOpacity(0.12);
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: tileColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: RadioListTile<int>(
                      title: Text(choices[i]),
                      value: i,
                      groupValue: _selectedIndex,
                      onChanged: _answered
                          ? null
                          : (val) {
                              setState(() {
                                _selectedIndex = val;
                              });
                            },
                      activeColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.check),
                      label: const Text('Check Answer'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _answered || _selectedIndex == null
                          ? null
                          : () {
                              setState(() {
                                _answered = true;
                              });
                            },
                    ),
                    if (_answered)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text('Try Again'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 12),
                            textStyle: const TextStyle(fontSize: 16),
                            foregroundColor: theme.colorScheme.primary,
                            side: BorderSide(color: theme.colorScheme.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _answered = false;
                              _selectedIndex = null;
                            });
                          },
                        ),
                      ),
                  ],
                ),
                if (_answered)
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Row(
                      children: [
                        Icon(
                          _selectedIndex == correctIndex
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: _selectedIndex == correctIndex
                              ? Colors.green
                              : Colors.red,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _selectedIndex == correctIndex
                                ? 'Correct!'
                                : 'Incorrect. The correct answer is:\n\n${choices[correctIndex]}',
                            style: TextStyle(
                              color: _selectedIndex == correctIndex
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
