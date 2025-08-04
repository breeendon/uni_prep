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
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6C5CE7), Color(0xFF74B9FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C5CE7).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child:
                        const Icon(Icons.school, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add AP Exam Score",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Track your AP performance",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Add Score Form
            Card(
              elevation: 8,
              shadowColor: Colors.black.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.grey.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      // AP Exam Dropdown
                      DropdownMenu<String>(
                        width: double.infinity,
                        onSelected: (test) {
                          setState(() {
                            selectedTest = test;
                          });
                        },
                        hintText: 'Select an AP Exam',
                        inputDecorationTheme: InputDecorationTheme(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: Color(0xFF6C5CE7), width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
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
                              value: 'AP Chemistry', label: 'AP Chemistry'),
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
                              value: 'AP Psychology', label: 'AP Psychology'),
                          DropdownMenuEntry(
                              value: 'AP Statistics', label: 'AP Statistics'),
                          DropdownMenuEntry(
                              value: 'AP United States History',
                              label: 'AP United States History'),
                          DropdownMenuEntry(
                              value: 'AP World History: Modern',
                              label: 'AP World History: Modern'),
                        ],
                        initialSelection: selectedTest,
                      ),
                      const SizedBox(height: 20),

                      // Score and Add Button Row
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade300),
                                color: Colors.white,
                              ),
                              child: DropdownButtonFormField<int>(
                                decoration: InputDecoration(
                                  labelText: 'Score',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                ),
                                value: selectedScore,
                                onChanged: (score) {
                                  setState(() {
                                    selectedScore = score;
                                  });
                                },
                                items: const [
                                  DropdownMenuItem<int>(
                                      value: 1, child: Text('1')),
                                  DropdownMenuItem<int>(
                                      value: 2, child: Text('2')),
                                  DropdownMenuItem<int>(
                                      value: 3, child: Text('3')),
                                  DropdownMenuItem<int>(
                                      value: 4, child: Text('4')),
                                  DropdownMenuItem<int>(
                                      value: 5, child: Text('5')),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6C5CE7), Color(0xFF74B9FF)],
                              ),
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF6C5CE7).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                if (selectedTest != null &&
                                    selectedScore != null) {
                                  appState.addApScore(
                                      selectedTest!, selectedScore!);
                                  setState(() {
                                    selectedTest = null;
                                    selectedScore = null;
                                  });
                                }
                              },
                              label: const Text('Add',
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Scores List Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6C5CE7).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.bar_chart,
                            color: Color(0xFF6C5CE7), size: 24),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "Your AP Scores",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2D3436),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (appState.apScores.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: Colors.grey.shade600, size: 24),
                          const SizedBox(width: 12),
                          Text(
                            "No AP scores added yet.",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (appState.apScores.isNotEmpty)
                    Column(
                      children: appState.apScores.entries.map((entry) {
                        final exam = entry.key;
                        final score = entry.value;
                        final scoreColor = _getScoreColor(score);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    scoreColor,
                                    scoreColor.withOpacity(0.7)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: scoreColor.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '$score',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              exam,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              _getScoreDescription(score),
                              style: TextStyle(
                                color: scoreColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.delete_outline,
                                    color: Colors.red.shade600),
                                tooltip: 'Remove score',
                                onPressed: () {
                                  appState.removeApScore(exam);
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(int score) {
    switch (score) {
      case 5:
        return const Color(0xFF00B894);
      case 4:
        return const Color(0xFF6C5CE7);
      case 3:
        return const Color(0xFF74B9FF);
      case 2:
        return const Color(0xFFE17055);
      case 1:
        return const Color(0xFFD63031);
      default:
        return Colors.grey;
    }
  }

  String _getScoreDescription(int score) {
    switch (score) {
      case 5:
        return 'Extremely well qualified';
      case 4:
        return 'Well qualified';
      case 3:
        return 'Qualified';
      case 2:
        return 'Possibly qualified';
      case 1:
        return 'No recommendation';
      default:
        return '';
    }
  }
}
