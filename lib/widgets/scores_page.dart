import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class ScoresPage extends StatefulWidget {
  const ScoresPage({super.key});

  @override
  State<ScoresPage> createState() => _ScoresPageState();
}

class _ScoresPageState extends State<ScoresPage> {
  int? selectedScore;
  String? selectedTest;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MyAppState>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.school, color: Colors.deepOrange, size: 32),
                const SizedBox(width: 10),
                Text(
                  "Add AP Exam Score",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: DropdownMenu<String>(
                        onSelected: (test) {
                          setState(() {
                            selectedTest = test;
                          });
                        },
                        hintText: 'Select an AP Exam',
                        dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(
                              value: 'AP African American Studies',
                              label: 'AP African American Studies'),
                          DropdownMenuEntry(
                              value: 'AP Art History', label: 'AP Art History'),
                          DropdownMenuEntry(
                              value: 'AP 2-D Art and Design',
                              label: 'AP 2-D Art and Design'),
                          DropdownMenuEntry(
                              value: 'AP 3-D Art and Design',
                              label: 'AP 3-D Art and Design'),
                          DropdownMenuEntry(
                              value: 'AP Drawing', label: 'AP Drawing'),
                          DropdownMenuEntry(
                              value: 'AP Biology', label: 'AP Biology'),
                          DropdownMenuEntry(
                              value: 'AP Calculus AB', label: 'AP Calculus AB'),
                          DropdownMenuEntry(
                              value: 'AP Calculus BC', label: 'AP Calculus BC'),
                          DropdownMenuEntry(
                              value: 'AP Calculus BC: AB Subscore',
                              label: 'AP Calculus BC: AB Subscore'),
                          DropdownMenuEntry(
                              value: 'AP Chemistry', label: 'AP Chemistry'),
                          DropdownMenuEntry(
                              value: 'AP Chinese Language and Culture',
                              label: 'AP Chinese Language and Culture'),
                          DropdownMenuEntry(
                              value: 'AP Comparative Government and Politics',
                              label: 'AP Comparative Government and Politics'),
                          DropdownMenuEntry(
                              value: 'AP Computer Science A',
                              label: 'AP Computer Science A'),
                          DropdownMenuEntry(
                              value: 'AP Computer Science Principles',
                              label: 'AP Computer Science Principles'),
                          DropdownMenuEntry(
                              value: 'AP English Language and Composition',
                              label: 'AP English Language and Composition'),
                          DropdownMenuEntry(
                              value: 'AP English Literature and Composition',
                              label: 'AP English Literature and Composition'),
                          DropdownMenuEntry(
                              value: 'AP Environmental Science',
                              label: 'AP Environmental Science'),
                          DropdownMenuEntry(
                              value: 'AP European History',
                              label: 'AP European History'),
                          DropdownMenuEntry(
                              value: 'AP French Language and Culture',
                              label: 'AP French Language and Culture'),
                          DropdownMenuEntry(
                              value: 'AP German Language and Culture',
                              label: 'AP German Language and Culture'),
                          DropdownMenuEntry(
                              value: 'AP Human Geography',
                              label: 'AP Human Geography'),
                          DropdownMenuEntry(
                              value: 'AP Italian Language and Culture',
                              label: 'AP Italian Language and Culture'),
                          DropdownMenuEntry(
                              value: 'AP Japanese Language and Culture',
                              label: 'AP Japanese Language and Culture'),
                          DropdownMenuEntry(
                              value: 'AP Latin', label: 'AP Latin'),
                          DropdownMenuEntry(
                              value: 'AP Macroeconomics',
                              label: 'AP Macroeconomics'),
                          DropdownMenuEntry(
                              value: 'AP Microeconomics',
                              label: 'AP Microeconomics'),
                          DropdownMenuEntry(
                              value: 'AP Music Theory',
                              label: 'AP Music Theory'),
                          DropdownMenuEntry(
                              value: 'AP Physics 1: Algebra-Based',
                              label: 'AP Physics 1: Algebra-Based'),
                          DropdownMenuEntry(
                              value: 'AP Physics 2: Algebra-Based',
                              label: 'AP Physics 2: Algebra-Based'),
                          DropdownMenuEntry(
                              value: 'AP Physics C: Electricity and Magnetism',
                              label: 'AP Physics C: Electricity and Magnetism'),
                          DropdownMenuEntry(
                              value: 'AP Physics C: Mechanics',
                              label: 'AP Physics C: Mechanics'),
                          DropdownMenuEntry(
                              value: 'AP Psychology', label: 'AP Psychology'),
                          DropdownMenuEntry(
                              value: 'AP Research', label: 'AP Research'),
                          DropdownMenuEntry(
                              value: 'AP Seminar', label: 'AP Seminar'),
                          DropdownMenuEntry(
                              value: 'AP Spanish Language and Culture',
                              label: 'AP Spanish Language and Culture'),
                          DropdownMenuEntry(
                              value: 'AP Spanish Literature and Culture',
                              label: 'AP Spanish Literature and Culture'),
                          DropdownMenuEntry(
                              value: 'AP Statistics', label: 'AP Statistics'),
                          DropdownMenuEntry(
                              value: 'AP United States Government and Politics',
                              label:
                                  'AP United States Government and Politics'),
                          DropdownMenuEntry(
                              value: 'AP United States History',
                              label: 'AP United States History'),
                          DropdownMenuEntry(
                              value: 'AP World History: Modern',
                              label: 'AP World History: Modern'),
                        ],
                        initialSelection: selectedTest,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        decoration: const InputDecoration(labelText: 'Score'),
                        value: selectedScore,
                        onChanged: (score) {
                          setState(() {
                            selectedScore = score;
                          });
                        },
                        items: const [
                          DropdownMenuItem<int>(value: 1, child: Text('1')),
                          DropdownMenuItem<int>(value: 2, child: Text('2')),
                          DropdownMenuItem<int>(value: 3, child: Text('3')),
                          DropdownMenuItem<int>(value: 4, child: Text('4')),
                          DropdownMenuItem<int>(value: 5, child: Text('5')),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        if (selectedTest != null && selectedScore != null) {
                          appState.addApScore(selectedTest!, selectedScore!);
                          setState(() {
                            selectedTest = null;
                            selectedScore = null;
                          });
                        }
                      },
                      label: const Text('Add'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Divider(),
            const SizedBox(height: 8),
            Text(
              "Your AP Scores",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            if (appState.apScores.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "No AP scores added yet.",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            if (appState.apScores.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: appState.apScores.length,
                itemBuilder: (BuildContext context, int index) {
                  final exam = appState.apScores.keys.elementAt(index);
                  final score = appState.apScores[exam];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepOrange,
                        child: Text(
                          '$score',
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(exam),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Remove score',
                        onPressed: () {
                          appState.removeApScore(exam);
                        },
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
