import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTaskDialog extends StatefulWidget {
  const NewTaskDialog({super.key});

  @override
  _NewTaskDialogState createState() => _NewTaskDialogState();
}

class _NewTaskDialogState extends State<NewTaskDialog> {
  String selectedTaskType = 'TodoQuest';
  int repeatDays = 1;
  DateTime? startDate;
  DateTime? endDate;
  int duration = 30; // สำหรับ FocusTimer
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startDateController.text = "Select Start Date";
    endDateController.text = "Select End Date";
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        height: 620,
        padding: const EdgeInsets.all(15),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('New Task'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Task Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedTaskType,
                    items: ['TodoQuest', 'FocusTimer'].map((String taskType) {
                      return DropdownMenuItem<String>(
                        value: taskType,
                        child: Text(taskType),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTaskType = newValue!;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Task Type',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  selectedTaskType == 'TodoQuest'
                      ? _buildTodoQuestOptions()
                      : _buildFocusTimerOptions(),
                  const SizedBox(height: 10),
                  const Text(
                    "Date Setting",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: startDateController,
                    decoration: const InputDecoration(
                      labelText: 'Start Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    readOnly: true,
                    onTap: () => _selectDate(context, true),
                  ),
                  const SizedBox(height: 20),
                  if (selectedTaskType == 'TodoQuest')
                    TextField(
                      controller: endDateController,
                      decoration: const InputDecoration(
                        labelText: 'End Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: () => _selectDate(context, false),
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 96, 137, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Logic to save the task goes here
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Create',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTodoQuestOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Repeat Every:'),
        DropdownButton<int>(
          value: repeatDays,
          items: [1, 2, 3, 7, 14].map((int day) {
            return DropdownMenuItem<int>(
              value: day,
              child: Text('$day days'),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              repeatDays = newValue!;
            });
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildFocusTimerOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Set Duration (minutes):'),
        DropdownButton<int>(
          value: duration,
          items: [15, 30, 45, 60, 90].map((int duration) {
            return DropdownMenuItem<int>(
              value: duration,
              child: Text('$duration minutes'),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              duration = newValue!;
            });
          },
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
          startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          endDate = picked;
          endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }
}
