import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmNewPassword = true;

  @override
  Widget build(BuildContext context) {
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
                        'Change Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildPasswordField(
                    controller: currentPasswordController,
                    hintText: 'Old Password*',
                    obscureText: _obscureCurrentPassword,
                    onToggle: () {
                      setState(() {
                        _obscureCurrentPassword = !_obscureCurrentPassword;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildPasswordField(
                    controller: newPasswordController,
                    hintText: 'New Password*',
                    obscureText: _obscureNewPassword,
                    onToggle: () {
                      setState(() {
                        _obscureNewPassword = !_obscureNewPassword;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildPasswordField(
                    controller: confirmNewPasswordController,
                    hintText: 'New Password*(re-enter)',
                    obscureText: _obscureConfirmNewPassword,
                    onToggle: () {
                      setState(() {
                        _obscureConfirmNewPassword =
                            !_obscureConfirmNewPassword;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserSuccess) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );

                              // Reset the password fields after a successful change
                              currentPasswordController.clear();
                              newPasswordController.clear();
                              confirmNewPasswordController.clear();
                            });
                          } else if (state is UserFailure) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)),
                              );
                            });
                          }
                          return TextButton(
                            onPressed: () {
                              if (newPasswordController.text !=
                                  confirmNewPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('New passwords do not match')),
                                );
                              } else {
                                _showConfirmationDialog(context);
                              }
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
                            child: const Text('Change'),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // ป้องกันไม่ให้ผู้ใช้ปิด dialog ขณะ loading
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Password Change'),
          content: const Text('Are you sure you want to change your password?'),
          backgroundColor: Colors.white,
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color.fromARGB(255, 98, 98, 98)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                // แสดง loading indicator
                showDialog(
                  context: context,
                  barrierDismissible: false, // ปิดไม่ได้ระหว่าง loading
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 255, 145, 77),
                      ),
                    );
                  },
                );

                // หน่วงเวลา 2 วินาทีแล้วจึงทำการอัปเดตข้อมูล
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.of(context).pop(); // ปิด loading dialog

                  // เรียกการเปลี่ยนรหัสผ่าน
                  context.read<UserBloc>().add(ChangePasswordEvent(
                        currentPassword: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                      ));

                  Navigator.of(context).pop(); // ปิด AlertDialog
                });
              },
              style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 145, 77)),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
