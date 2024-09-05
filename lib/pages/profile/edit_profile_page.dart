import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

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
            const Spacer(), // ใช้ Spacer เพื่อจัดตำแหน่ง
            // const Text(
            //   'Store',
            //   style: TextStyle(
            //     fontSize: 20,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const Spacer(), // ใช้ Spacer เพื่อจัดตำแหน่ง
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                // ทำอะไรบางอย่างเมื่อกดปุ่ม
              },
              iconSize: 30,
            ),
          ],
        ),
        automaticallyImplyLeading: false, // ปิดปุ่ม Back
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: SingleChildScrollView( // เพิ่อให้สามารถเลื่อนหน้าจอได้ถ้าคอนเทนต์ใหญ่เกิน 
            child: Center(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      const SizedBox(width: 5),
                      const Icon(Icons.edit_outlined, size: 23.0),
                      const SizedBox(width: 10),
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
                  Image.asset(
                    'assets/account_image.png',
                    height: 160,
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'steven007',
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
                          decoration: InputDecoration(
                            hintText: 'Steven',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Strange',
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
                    decoration: InputDecoration(
                      hintText: 'steven.s@email.com',
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
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 161, 161, 161),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 10),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 145, 77),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
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
            ),
          ),
        ),
      ),
    );
  }
}
