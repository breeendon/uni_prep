import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'college_data.dart';

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
                              final appState = Provider.of<MyAppState>(context,
                                  listen: false);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  final theme = Theme.of(context);
                                  final isDark =
                                      theme.brightness == Brightness.dark;

                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      constraints: const BoxConstraints(
                                        maxWidth: 500,
                                        maxHeight: 600,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                          colors: isDark
                                              ? [
                                                  const Color(0xFF2D2D2D),
                                                  const Color(0xFF404040)
                                                ]
                                              : [
                                                  Colors.white,
                                                  Colors.grey.shade50
                                                ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Header
                                          Container(
                                            padding: const EdgeInsets.all(24),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xFF6C5CE7),
                                                  Color(0xFF74B9FF)
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: const Icon(
                                                    Icons.school,
                                                    color: Colors.white,
                                                    size: 24,
                                                  ),
                                                ),
                                                const SizedBox(width: 16),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        college,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      const Text(
                                                        'AP Credit Policy',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.white70,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(Icons.close,
                                                      color: Colors.white),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Content
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.all(24),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  if (appState
                                                      .apScores.isEmpty) ...[
                                                    Center(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isDark
                                                                  ? const Color(
                                                                      0xFF404040)
                                                                  : Colors.grey
                                                                      .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                            ),
                                                            child: Icon(
                                                              Icons
                                                                  .quiz_outlined,
                                                              size: 48,
                                                              color: isDark
                                                                  ? Colors.grey
                                                                      .shade400
                                                                  : Colors.grey
                                                                      .shade600,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 16),
                                                          Text(
                                                            'No AP scores added yet',
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: isDark
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black87,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          Text(
                                                            'Add your AP exam scores to see credit eligibility',
                                                            style: TextStyle(
                                                              color: isDark
                                                                  ? Colors.grey
                                                                      .shade400
                                                                  : Colors.grey
                                                                      .shade600,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ] else ...[
                                                    Text(
                                                      'Your AP Exams and Credit Status:',
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: isDark
                                                            ? Colors.white
                                                            : Colors.black87,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Flexible(
                                                      child: ListView.separated(
                                                        shrinkWrap: true,
                                                        itemCount: appState
                                                            .apScores
                                                            .keys
                                                            .length,
                                                        separatorBuilder:
                                                            (context, index) =>
                                                                const SizedBox(
                                                                    height: 12),
                                                        itemBuilder:
                                                            (context, index) {
                                                          final exam = appState
                                                              .apScores.keys
                                                              .elementAt(index);
                                                          final userScore =
                                                              appState.apScores[
                                                                  exam];
                                                          final policy =
                                                              getApCreditPolicy(
                                                                  exam);
                                                          final minScore =
                                                              policy?[college];

                                                          Color statusColor;
                                                          IconData statusIcon;
                                                          String statusText;

                                                          if (minScore !=
                                                              null) {
                                                            if (userScore! >=
                                                                minScore) {
                                                              statusColor =
                                                                  Colors.green;
                                                              statusIcon = Icons
                                                                  .check_circle;
                                                              statusText =
                                                                  'Credit Awarded';
                                                            } else {
                                                              statusColor =
                                                                  Colors.orange;
                                                              statusIcon =
                                                                  Icons.warning;
                                                              statusText =
                                                                  'No Credit';
                                                            }
                                                          } else {
                                                            statusColor =
                                                                Colors.grey;
                                                            statusIcon =
                                                                Icons.block;
                                                            statusText =
                                                                'Not Accepted';
                                                          }

                                                          return Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(16),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: isDark
                                                                  ? const Color(
                                                                      0xFF404040)
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              border:
                                                                  Border.all(
                                                                color: statusColor
                                                                    .withOpacity(
                                                                        0.3),
                                                                width: 1.5,
                                                              ),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.05),
                                                                  blurRadius: 8,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 2),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: statusColor
                                                                        .withOpacity(
                                                                            0.1),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child: Icon(
                                                                    statusIcon,
                                                                    color:
                                                                        statusColor,
                                                                    size: 20,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 12),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        exam,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color: isDark
                                                                              ? Colors.white
                                                                              : Colors.black87,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              4),
                                                                      Row(
                                                                        children: [
                                                                          Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(
                                                                              horizontal: 8,
                                                                              vertical: 2,
                                                                            ),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: statusColor.withOpacity(0.1),
                                                                              borderRadius: BorderRadius.circular(4),
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              statusText,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: statusColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 8),
                                                                          Text(
                                                                            'Score: $userScore',
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              color: isDark ? Colors.grey.shade300 : Colors.grey.shade600,
                                                                            ),
                                                                          ),
                                                                          if (minScore !=
                                                                              null) ...[
                                                                            Text(
                                                                              ' • Min: $minScore',
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                color: isDark ? Colors.grey.shade300 : Colors.grey.shade600,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
