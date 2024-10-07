import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
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
          child: SingleChildScrollView(
            child: Center(
              child:
                  BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                if (state is UserSuccess) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const BottomNavigationPage(initialIndex: 3),
                        transitionDuration: const Duration(seconds: 0),
                      ),
                    );
                  });
                } else if (state is UserFailure) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  });
                }

                // แสดง loading indicator เมื่อ state เป็น UserLoading
                return Stack(
                  children: [
                    Column(
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
                                }),
                            const SizedBox(width: 5),
                            const Text(
                              'Edit Profile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText: state.user.username,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  hintText: state.user.firstName,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  hintText: state.user.lastName,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: state.user.email,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 161, 161, 161),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text('Cancel'),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                _showConfirmDialog(
                                    context,
                                    state,
                                    usernameController,
                                    firstNameController,
                                    lastNameController,
                                    emailController);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 145, 77),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 60.0, vertical: 10.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text('Edit'),
                            ),
                          ],
                        )
                      ],
                    ),
                    if (state
                        is UserLoading) // แสดง loading indicator เมื่อกำลังบันทึกข้อมูล
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmDialog(
      BuildContext context,
      UserState state,
      TextEditingController usernameController,
      TextEditingController firstNameController,
      TextEditingController lastNameController,
      TextEditingController emailController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Edit"),
          content: const Text("Are you sure you want to edit your profile?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด dialog ถ้าไม่ยืนยัน
              },
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                // ยืนยันการแก้ไข
                final updatedUsername = usernameController.text.isNotEmpty
                    ? usernameController.text
                    : state.user.username;

                final updatedFirstName = firstNameController.text.isNotEmpty
                    ? firstNameController.text
                    : state.user.firstName;

                final updatedLastName = lastNameController.text.isNotEmpty
                    ? lastNameController.text
                    : state.user.lastName;

                final updatedEmail = emailController.text.isNotEmpty
                    ? emailController.text
                    : state.user.email;
                // Clear text controllers after confirmation
                usernameController.clear();
                firstNameController.clear();
                lastNameController.clear();
                emailController.clear();

                context.read<UserBloc>().add(UpdateUserEvent(
                      username: updatedUsername,
                      firstName: updatedFirstName,
                      lastName: updatedLastName,
                      email: updatedEmail,
                    ));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
