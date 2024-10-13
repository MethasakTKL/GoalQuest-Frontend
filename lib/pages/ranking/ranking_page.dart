import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';
// import 'package:goal_quest/mockup/user_models_list.dart';
// import 'package:goal_quest/mockup/user_rankings_list.dart';
import 'package:goal_quest/models/models.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final mockRankingData = userRankingsList;
    // final currentUser = usersList;
    context.read<UserBloc>().add(GetAllUsersEvent());
    context.read<PointBloc>().add(LoadAllPointsEvent());

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
          builder: (context, userState) {
            debugPrint('UserState Ranking: $userState');
            return BlocBuilder<PointBloc, PointState>(
              builder: (context, pointState) {
                debugPrint('PointState: $pointState');
                if (userState is AllUsersLoaded &&
                    pointState is ReadyPointState) {
                  final allUsers = userState.usersList;
                  final allPoints = pointState.points;

                  debugPrint(
                      'All Users: ${allUsers.map((u) => u.username).toList()}');
                  debugPrint(
                      'All Points: ${allPoints.map((p) => p.totalPoint).toList()}');
                  // แผนที่ผู้ใช้กับคะแนนตาม user_id
                  final userWithPoints = allUsers.map((user) {
                    final userPoint = allPoints.firstWhere(
                        (point) => point.userId == user.id, orElse: () {
                      debugPrint(
                          'No points found for user: ${user.username} (ID: ${user.id})');
                      return PointModel.empty(); // ถ้าไม่มีคะแนน
                    });

                    debugPrint(
                        'User: ${user.username}, Points: ${userPoint.totalPoint}'); // ตรวจสอบคะแนนของผู้ใช้
                    return {
                      'user': user,
                      'points': userPoint.totalPoint, // คะแนนรวมจาก PointModel
                    };
                  }).toList();

                  // จัดเรียงลำดับผู้ใช้ตามคะแนน
                  userWithPoints.sort((a, b) {
                    // ใช้ null-aware operator เพื่อป้องกันการเรียก compareTo ถ้าค่าเป็น null
                    final pointsA =
                        a['points'] as int? ?? 0; // ถ้าเป็น null ให้ใช้ค่า 0
                    final pointsB =
                        b['points'] as int? ?? 0; // ถ้าเป็น null ให้ใช้ค่า 0
                    return pointsB.compareTo(pointsA); // เปรียบเทียบคะแนน
                  });

                  debugPrint(
                      'Sorted users by points: ${userWithPoints.map((u) => "${(u['user'] as UserModel).username}: ${u['points']}").toList()}');

                  int currentUserRank = userWithPoints.indexWhere((user) =>
                          (user['user'] as UserModel).id ==
                          context.read<UserBloc>().state.user.id) +
                      1;

                  final currentUser = context.read<UserBloc>().state.user;
                  final currentUserPoint = pointState.points.firstWhere(
                    (point) => point.userId == currentUser.id,
                    orElse: () => PointModel.empty(),
                  );

                  String getOrdinalSuffix(int number) {
                    if (number >= 11 && number <= 13) {
                      return 'th';
                    }
                    switch (number % 10) {
                      case 1:
                        return 'st';
                      case 2:
                        return 'nd';
                      case 3:
                        return 'rd';
                      default:
                        return 'th';
                    }
                  }

                  // ข้อมูล Top 3
                  final top3Users = userWithPoints.take(3).toList();
                  final remainingUsers = userWithPoints.skip(3).toList();

                  return Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 20),
                          Stack(
                            alignment: Alignment.center,
                            children: [
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
                              // Winner (อันดับ 1)
                              Positioned(
                                top: 0,
                                child: Column(
                                  children: [
                                    const CircleAvatar(
                                      radius: 40,
                                      backgroundImage: AssetImage(
                                          'assets/mockup/rank_1.png'), // สามารถเปลี่ยนเป็นรูปของผู้ใช้ได้
                                    ),
                                    Text(
                                      (top3Users[0]['user'] as UserModel)
                                          .username,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${top3Users[0]['points']}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 7, 88, 220),
                                          ),
                                        ),
                                        const SizedBox(width: 3),
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
                              ),
                              Positioned(
                                top: 110,
                                left: 255,
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          'assets/mockup/rank_2.png'),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        Text(
                                          (top3Users[1]['user'] as UserModel)
                                              .username,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${top3Users[1]['points']}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 7, 88, 220),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            const Icon(
                                              Icons.savings_outlined,
                                              size: 13,
                                              color: Color.fromARGB(
                                                  255, 7, 88, 220),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 123,
                                right: 255,
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          (top3Users[2]['user'] as UserModel)
                                              .username,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${top3Users[2]['points']}',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 7, 88, 220),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            const Icon(
                                              Icons.savings_outlined,
                                              size: 13,
                                              color: Color.fromARGB(
                                                  255, 7, 88, 220),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 5),
                                    const CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          'assets/mockup/rank_3.png'),
                                    ),
                                  ],
                                ),
                              ),

                              // รหัสที่เหลือเหมือนเดิม
                            ],
                          ),
                          const SizedBox(height: 0),
                          // รายชื่อผู้ใช้ที่เหลือ
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: ListView.builder(
                                    itemCount: remainingUsers.length > 7
                                        ? 7
                                        : remainingUsers.length,
                                    padding: const EdgeInsets.only(bottom: 80),
                                    itemBuilder: (context, index) {
                                      int rank = index + 4;
                                      return ListTile(
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[700],
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            rank.toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        title: Text((remainingUsers[index]
                                                ['user'] as UserModel)
                                            .username),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              '${remainingUsers[index]['points']}',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 89, 125, 197),
                                              ),
                                            ),
                                            const SizedBox(width: 3),
                                            const Icon(
                                              Icons.savings_outlined,
                                              size: 16,
                                              color: Color.fromARGB(
                                                  255, 89, 125, 197),
                                            ),
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
                      // เพิ่ม section ของคะแนนผู้ใช้ปัจจุบันเหมือนเดิม
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          context
                                              .read<UserBloc>()
                                              .state
                                              .user
                                              .username,
                                          style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 219, 238, 255),
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${currentUserPoint.totalPoint}',
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 219, 238, 255),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Icon(
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
                                Row(
                                  children: [
                                    Text(
                                      'Rank $currentUserRank${getOrdinalSuffix(currentUserRank)}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Icon(
                                      Icons.bookmark,
                                      color: Color.fromARGB(255, 77, 172, 255),
                                    ),
                                    const SizedBox(
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
                } else if (userState is UserLoading ||
                    pointState is LodingPointState) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(
                      child: Text('Failed to load users or points'));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
