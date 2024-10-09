import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
import 'package:goal_quest/mockup/user_models_list.dart';
import 'package:goal_quest/mockup/user_rankings_list.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mockRankingData = userRankingsList;
    final currentUser = usersList;
    context.read<UserBloc>().add(GetAllUsersEvent());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 79, 195, 247),
        title: Row(
          children: [
            Image.asset(
              'assets/logo_black.png',
              height: 50,
            ),
            const Spacer(),
            const Text(
              'Ranking',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.account_circle),
              color: const Color.fromARGB(255, 0, 0, 0),
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
      body: Container(
        // เพิ่มไล่เฉดสีพื้นหลัง
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4FC3F7), // สีฟ้าอ่อน
              Color(0xFFFFFFFF), // สีขาว
            ],
          ),
        ),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is AllUsersLoaded) {
              final allUsers = state.usersList;
              // allUsers.sort((a, b) => b.id.compareTo(a.id)); // ปรับลำดับ point ทีหลัง
              final top3Users =
                  allUsers.take(3).toList(); // ดึงข้อมูลของ top 3 ไว้
              final remainingUsers =
                  allUsers.skip(3).toList(); // ตั้งแต่ที่ 4 ขึ้นไป
              return Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Podium Image
                          Padding(
                            padding: const EdgeInsets.only(top: 125),
                            child: Center(
                              child: Image.asset(
                                'assets/ranking.png',
                                width: 250,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          // Positioned for 1st, 2nd, 3rd place user images and points

                          Positioned(
                            top: 0,
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      AssetImage(mockRankingData[0].image),
                                ),
                                Text(
                                  top3Users[0].username,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${mockRankingData[0].point}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 7, 88, 220),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    const Icon(
                                      Icons.savings_outlined,
                                      size: 13,
                                      color: Color.fromARGB(255, 7, 88, 220),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top:
                                -8, // กำหนดตำแหน่งของรูป winner.png ด้านบนของ CircleAvatar
                            right: 182, // ด้านขวา
                            child: Image.asset(
                              'assets/winner.png',
                              width: 40, // กำหนดขนาดของรูปตามที่คุณต้องการ
                              height: 40,
                            ),
                          ),
                          // Second place user (on the right)
                          Positioned(
                            top: 110,
                            left: 255,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage(mockRankingData[1].image),
                                ),
                                const SizedBox(width: 5),
                                Column(
                                  children: [
                                    Text(
                                      top3Users[1].username,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${mockRankingData[1].point}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 7, 88, 220),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        const Icon(
                                          Icons.savings_outlined,
                                          size: 13,
                                          color:
                                              Color.fromARGB(255, 7, 88, 220),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Third place user (on the left)
                          Positioned(
                            top: 123,
                            right: 255,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      top3Users[2].username,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${mockRankingData[2].point}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 7, 88, 220),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        const Icon(
                                          Icons.savings_outlined,
                                          size: 13,
                                          color:
                                              Color.fromARGB(255, 7, 88, 220),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 5),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage(mockRankingData[2].image),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 0),

                      // Expandable scrollable list of other rankings with gray background and curved borders
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: ListView.builder(
                                itemCount: remainingUsers
                                    .take(7)
                                    .length, // จำนวนที่เหลือนอกเหนือจาก top 3
                                padding: const EdgeInsets.only(bottom: 80),
                                itemBuilder: (context, index) {
                                  int rank = index + 4;
                                  return ListTile(
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[700], // สีเทาเข้ม
                                        shape: BoxShape.circle, // ทำเป็นวงกลม
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        rank.toString(), // แสดงลำดับที่เป็นตัวเลข
                                        style: const TextStyle(
                                          color: Colors
                                              .white, // สีข้อความเป็นสีขาว
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    title: Text(remainingUsers[index]
                                        .username), // แสดงชื่อผู้ใช้งานตามลำดับ
                                    trailing: const Row(
                                      mainAxisSize: MainAxisSize
                                          .min, // เพื่อให้ไอคอนไม่ใช้พื้นที่มากเกินไป
                                      children: [
                                        // Text(
                                        //   '${currentUser[index + 1].point}',
                                        //   style: const TextStyle(
                                        //     fontSize: 12,
                                        //     color: Color.fromARGB(
                                        //         255, 89, 125, 197),
                                        //   ),
                                        // ),
                                        SizedBox(
                                            width:
                                                3), // เพิ่มระยะห่างระหว่างข้อความกับไอคอน
                                        Icon(Icons.savings_outlined,
                                            size: 16, // ขนาดไอคอน
                                            color: Color.fromARGB(
                                                255, 89, 125, 197)),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Fixed current user's score section as a Stack, overlapping the ListView
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/user_image.png'),
                                ),
                                const SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${state.user.username}',
                                      style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 219, 238, 255),
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Row(
                                      children: [
                                        Text(
                                          '1000',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 219, 238, 255),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Icon(
                                          Icons.savings_outlined,
                                          size: 20,
                                          color: Color.fromARGB(
                                              255, 219, 238, 255),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                Text(
                                  'Rank 12th',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.bookmark,
                                  color: Color.fromARGB(255, 77, 172, 255),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('Failed to load users'));
            }
          },
        ),
      ),
    );
  }
}
