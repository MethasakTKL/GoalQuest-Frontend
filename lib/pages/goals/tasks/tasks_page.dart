import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/pages/goals/tasks/focustimer/focustimer_list.dart';
import 'package:goal_quest/pages/goals/tasks/todoquest/todoquest_list.dart';
import 'package:goal_quest/pages/goals/tasks/new_task_dialog.dart'; // Import the new dialog

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  TasksPageState createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: Row(
            children: [
              Image.asset(
                'assets/logo_black.png',
                height: 50,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          const BottomNavigationPage(initialIndex: 3),
                      transitionDuration: const Duration(seconds: 0),
                    ),
                  );
                },
                iconSize: 30,
              ),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 26,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'ลดน้ำหนัก 10 กิโล',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'New Task',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const NewTaskDialog();
                          },
                        );
                      },
                      iconSize: 40,
                    ),
                  ],
                ),
                const SizedBox(height: 0),
                const TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Color.fromARGB(255, 95, 148, 80),
                  tabs: [
                    Tab(text: 'TodoQuest'),
                    Tab(text: 'FocusTimer'),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                        child: Column(
                          children: [
                            TextField(
                              controller: _searchController,
                              onTapOutside: (_) =>
                                  FocusScope.of(context).unfocus(),
                              onChanged: (key) {
                                context
                                    .read<TaskBloc>()
                                    .add(SearchTaskEvent(key));
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Align(
                                  alignment: Alignment.center,
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                                hintText: 'Search Task name',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Expanded(
                              child: TodoQuestList(),
                            ),
                          ],
                        ),
                      ),
                      const FocusTimerList(),
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
