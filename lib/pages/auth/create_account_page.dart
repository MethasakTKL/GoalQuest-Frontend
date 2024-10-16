import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // void _createAccount(BuildContext context) {
  //   if (_usernameController.text.isEmpty ||
  //       _firstnameController.text.isEmpty ||
  //       _lastnameController.text.isEmpty ||
  //       _emailController.text.isEmpty ||
  //       _passwordController.text.isEmpty ||
  //       _confirmPasswordController.text.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please fill all fields')),
  //     );
  //     return;
  //   }

  //   if (_passwordController.text != _confirmPasswordController.text) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Passwords do not match')),
  //     );
  //     return;
  //   }

  //   BlocProvider.of<UserBloc>(context).add(
  //     CreateUserEvent(
  //       username: _usernameController.text,
  //       firstName: _firstnameController.text,
  //       lastName: _lastnameController.text,
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     ),
  //   );

  // final url = Uri.parse('http://10.0.2.2:8000/users/');
  // try {
  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode({
  //       'username': _usernameController.text,
  //       'first_name': _firstnameController.text,
  //       'last_name': _lastnameController.text,
  //       'email': _emailController.text,
  //       'password': _passwordController.text,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Account created successfully')),
  //     );
  //     Navigator.pushReplacementNamed(context, '/login');
  //   } else {
  //     final errorData = json.decode(response.body);
  //     String errorMessage = 'Failed to create account';
  //     if (errorData is Map<String, dynamic> &&
  //         errorData.containsKey('detail')) {
  //       errorMessage = errorData['detail'].toString();
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(errorMessage)),
  //     );
  //   }
  // } catch (e) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text('Error: ${e.toString()}')),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserCreated) {
          // Handle successful user creation
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Account created successfully')),
            );
            Navigator.pushReplacementNamed(context, '/login');
          });
        } else if (state is UserFailure) {
          // Handle user creation error
          SchedulerBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          });
        }
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.black),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            Image.asset(
                              'assets/logo_black.png',
                              height: 70,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          children: [
                            Text(
                              'Create Account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Username*',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _firstnameController,
                                decoration: InputDecoration(
                                  hintText: 'Firstname*',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: TextField(
                                controller: _lastnameController,
                                decoration: InputDecoration(
                                  hintText: 'Lastname*',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email*',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password*',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: const Icon(Icons.info_outline),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password* (Re enter)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            suffixIcon: const Icon(Icons.info_outline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_passwordController.text ==
                        _confirmPasswordController.text) {
                      String username = _usernameController.text;
                      String firstName = _firstnameController.text;
                      String lastName = _lastnameController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      context.read<UserBloc>().add(CreateUserEvent(
                          username: username,
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          password: password));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Passwords do not match')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 14, 176, 212),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Create',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    "Do you have Account? Login",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 52, 52, 52),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
