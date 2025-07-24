import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'college_data.dart'; // Make sure this is present and correct

List<String> schools = [];

class CollegeList extends StatefulWidget {
  const CollegeList({super.key});

  @override
  State<CollegeList> createState() => _CollegeListState();
}

class _CollegeListState extends State<CollegeList> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  final int _suggestionLimit = 10;

  // ...allColleges and collegeUrls are now imported from college_data.dart
  // AP credit policies are now imported from college_data.dart

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MyAppState>(context);
    // Filter and sort colleges by relevance
    List<String> filteredColleges;
    if (_searchText.isEmpty) {
      filteredColleges = allColleges.take(_suggestionLimit).toList();
    } else {
      final lower = _searchText.toLowerCase();
      final startsWith =
          allColleges.where((c) => c.toLowerCase().startsWith(lower)).toList();
      final contains = allColleges
          .where((c) =>
              c.toLowerCase().contains(lower) &&
              !c.toLowerCase().startsWith(lower))
          .toList();
      filteredColleges = [...startsWith, ...contains];
      if (filteredColleges.length > _suggestionLimit) {
        filteredColleges = filteredColleges.take(_suggestionLimit).toList();
      }
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.show_chart_sharp,
                    color: Colors.deepOrange, size: 32),
                const SizedBox(width: 10),
                Text(
                  "My College List",
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
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search for a college',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (filteredColleges.isNotEmpty)
              Card(
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: filteredColleges.length,
                    itemBuilder: (context, index) {
                      final college = filteredColleges[index];
                      // Highlight matching part
                      final lowerCollege = college.toLowerCase();
                      final lowerSearch = _searchText.toLowerCase();
                      int matchStart = lowerCollege.indexOf(lowerSearch);
                      Widget title;
                      if (_searchText.isNotEmpty && matchStart != -1) {
                        title = RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: college.substring(0, matchStart),
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                  text: college.substring(matchStart,
                                      matchStart + _searchText.length),
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: college.substring(
                                      matchStart + _searchText.length),
                                  style: TextStyle(color: Colors.black)),
                            ],
                            style: DefaultTextStyle.of(context).style,
                          ),
                        );
                      } else {
                        title = Text(college);
                      }
                      return ListTile(
                        title: title,
                        onTap: () {
                          appState.addCollege(college);
                          _searchController.clear();
                          setState(() {
                            _searchText = '';
                          });
                        },
                        trailing:
                            const Icon(Icons.add, color: Colors.deepOrange),
                      );
                    },
                  ),
                ),
              ),
            if (filteredColleges.isEmpty && _searchText.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('No colleges found.',
                    style: TextStyle(color: Colors.grey)),
              ),
            const SizedBox(height: 20),
            Divider(),
            const SizedBox(height: 8),
            Text(
              "Your Colleges",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            if (appState.userColleges.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "No colleges added yet.",
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            if (appState.userColleges.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: appState.userColleges.length,
                itemBuilder: (context, index) {
                  final college = appState.userColleges[index];
                  return Card(
                    child: ListTile(
                      title: Text(college,
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.info_outline,
                                color: Colors.blue),
                            tooltip: 'View AP credit info',
                            onPressed: () {
                              final apInfo = apCreditPolicies[college];
                              final appState = Provider.of<MyAppState>(context,
                                  listen: false);
                              List<Widget> infoWidgets = [];
                              if (apInfo == null) {
                                infoWidgets.add(
                                    const Text('No AP credit info available.'));
                              } else {
                                infoWidgets.add(const Text(
                                    'Accepted AP Exams and Minimum Scores:'));
                                infoWidgets.add(const SizedBox(height: 10));
                                // Show all AP exams the user has entered
                                final userExams =
                                    appState.apScores.keys.toSet();
                                final collegeExams = apInfo.keys.toSet();
                                final allExams = {
                                  ...userExams,
                                  ...collegeExams
                                };
                                for (final exam in allExams) {
                                  final userScore = appState.apScores[exam];
                                  final minScore = apInfo[exam];
                                  if (minScore != null && userScore != null) {
                                    if (userScore >= minScore) {
                                      infoWidgets.add(Row(children: [
                                        Icon(Icons.check,
                                            color: Colors.green, size: 18),
                                        SizedBox(width: 6),
                                        Text(
                                            '$exam: $userScore (credit, min $minScore)'),
                                      ]));
                                    } else {
                                      infoWidgets.add(Row(children: [
                                        Icon(Icons.close,
                                            color: Colors.red, size: 18),
                                        SizedBox(width: 6),
                                        Text(
                                            '$exam: $userScore (no credit, min $minScore)'),
                                      ]));
                                    }
                                  } else if (minScore != null) {
                                    infoWidgets
                                        .add(Text('$exam: min $minScore'));
                                  } else if (userScore != null) {
                                    infoWidgets.add(Row(children: [
                                      Icon(Icons.block,
                                          color: Colors.grey, size: 18),
                                      SizedBox(width: 6),
                                      Text('$exam: $userScore (not accepted)'),
                                    ]));
                                  }
                                }
                              }
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(college),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: infoWidgets,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            tooltip: 'Remove college',
                            onPressed: () {
                              appState.removeCollege(college);
                            },
                          ),
                        ],
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
