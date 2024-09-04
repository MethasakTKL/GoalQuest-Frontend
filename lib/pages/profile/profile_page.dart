import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/logo_black.png',
              height: 50,
            ),
            const Spacer(),
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // ทำอะไรบางอย่างเมื่อกดปุ่ม
              },
              iconSize: 30,
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        child: Center(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(66, 70, 205, 0.612),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/account_image.png',
                      height: 120,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 25, 10, 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Steven Strange",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.person_outlined,
                                size: 19,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "steven007",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.email_outlined,
                                size: 19,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "steven.s@email.com",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context, '/login', (route) => false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(
                                        66, 70, 205, 0.612),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // ปรับมุมปุ่มให้มนเพียงเล็กน้อย
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.logout_outlined,
                                        size: 19,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Logout',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(
                                        66, 70, 205, 0.612),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '1250 Points',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(  // สำหรับกดเพื่อเปลี่ยนหน้าต่าง
                onTap: () {
                  Navigator.pushNamed(context, '/edit_profile');
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(156, 208, 208, 208),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 25,
                          color: Color.fromARGB(255, 64, 64, 64),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Edit Profile",
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color.fromARGB(255, 64, 64, 64),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(  // สำหรับกดเพื่อเปลี่ยนหน้าต่าง
              onTap: () {
                  Navigator.pushNamed(context, '/changee_password');
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(156, 208, 208, 208),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.password,
                          size: 25,
                          color: Color.fromARGB(255, 64, 64, 64),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Change Password",
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color.fromARGB(255, 64, 64, 64),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(  // สำหรับกดเพื่อเปลี่ยนหน้าต่าง
              onTap: () {
                Navigator.pushNamed(context, '/redeem_history');
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(156, 208, 208, 208),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 10, 0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.history,
                          size: 25,
                          color: Color.fromARGB(255, 64, 64, 64),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Redeem History",
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color.fromARGB(255, 64, 64, 64),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
