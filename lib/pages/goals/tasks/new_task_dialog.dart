import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:intl/intl.dart';

class NewTaskDialog extends StatefulWidget {
  final int goalId;
  const NewTaskDialog({super.key, required this.goalId});

  @override
  _NewTaskDialogState createState() => _NewTaskDialogState();
}

class _NewTaskDialogState extends State<NewTaskDialog> {
  String selectedTaskType = 'TodoQuest';
  int repeatDaysInput = 1;
  DateTime? startDateTime;
  DateTime? endDateTime;
  int durationInput = 15; // สำหรับ FocusTimer
  final TextEditingController titleController = TextEditingController();
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
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
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Task Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedTaskType,
                    dropdownColor: const Color.fromARGB(
                        255, 255, 255, 255), // เปลี่ยนสีพื้นหลังของ Dropdown
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
                      String title = titleController.text;
                      String taskType = selectedTaskType;
                      int repeatDays = repeatDaysInput;
                      int duration = durationInput;
                      DateTime startDate = startDateTime ?? DateTime.now();
                      DateTime endDate = endDateTime ?? DateTime.now();
                      context.read<TaskBloc>().add(AddTaskEvent(
                          widget.goalId,
                          title,
                          taskType,
                          repeatDays,
                          duration,
                          startDate,
                          endDate));
                      context.read<TaskBloc>().add(LoadTaskEvent());

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
          value: repeatDaysInput,
          dropdownColor: const Color.fromARGB(
              255, 255, 255, 255), // เปลี่ยนสีพื้นหลังของ Dropdown
          items: [1, 2, 3, 7, 14].map((int day) {
            return DropdownMenuItem<int>(
              value: day,
              child: Text(
                '$day days',
                style: const TextStyle(
                    color: Colors.black), // กำหนดสีของข้อความใน Dropdown
              ),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              repeatDaysInput = newValue!;
            });
          },
          style: const TextStyle(
              color: Colors.black), // กำหนดสีของข้อความใน DropdownButton
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
          value: durationInput,
          dropdownColor: const Color.fromARGB(
              255, 255, 255, 255), // เปลี่ยนสีพื้นหลังของ Dropdown
          items: [5, 10, 15, 30, 45, 60, 90, 100, 120, 150].map((int duration) {
            return DropdownMenuItem<int>(
              value: duration,
              child: Text(
                '$duration minutes',
                style: const TextStyle(
                    color: Colors.black), // กำหนดสีของข้อความใน Dropdown
              ),
            );
          }).toList(),
          onChanged: (int? newValue) {
            setState(() {
              durationInput = newValue!;
            });
          },
          style: const TextStyle(
              color: Colors.black), // กำหนดสีของข้อความใน DropdownButton
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
      // ใช้ ThemeData เพื่อปรับแต่งสี
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromARGB(255, 96, 137, 52), // สีหลัก
            hintColor: const Color.fromARGB(255, 96, 137, 52), // สีของปุ่ม
            colorScheme: ColorScheme.light(
                primary: const Color.fromARGB(255, 96, 137, 52)), // สีปุ่ม
            buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary), // ปรับปุ่มให้เป็นสีหลัก
            // เปลี่ยนสีวันปัจจุบัน
            dialogBackgroundColor: Colors.white, // พื้นหลังของ Dialog
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDateTime = picked;
          startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        } else {
          endDateTime = picked;
          endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
        }
      });
    }
  }
}
