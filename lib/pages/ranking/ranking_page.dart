import 'package:flutter/material.dart';
import 'package:goal_quest/bottom_navigationbar/navigation_page.dart';

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 195, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 195, 255),
        title: Row(
          children: [
            Image.asset(
              'assets/logo_white.png',
              height: 50,
            ),
            const Spacer(),
            const Text(
              'Ranking',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.account_circle),
              color: Colors.white,
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
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildTopThree(),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 25, 25, 31),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: _buildRankingList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopThree() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildTopThreeItem(
            'Jennie', '2780', 2, const Color.fromARGB(255, 131, 75, 216)),
        _buildTopThreeItem(
            'Wade', '3250', 1, const Color.fromARGB(255, 184, 71, 71)),
        _buildTopThreeItem(
            'Vinxen', '2750', 3, const Color.fromARGB(255, 186, 97, 168)),
      ],
    );
  }

  Widget _buildTopThreeItem(
      String name, String points, int position, Color color) {
    double height = position == 1 ? 130 : 90;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width:
              90, // กำหนดขนาดให้ใหญ่กว่าขนาดของ CircleAvatar เพื่อให้ขอบแสดงผล
          height: 90,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            child: ClipOval(
              child: Image.asset(
                'assets/user_image.png',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Text(name,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            )),
        Row(
          children: [
            Text(points,
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            const SizedBox(width: 4),
            const Icon(
              Icons.savings_outlined,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: 100,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15), // Rounded corners
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                position.toString(),
                style: const TextStyle(
                    fontSize: 50, color: Colors.white, fontFamily: 'Barlow'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRankingList() {
    final rankingData = [
      {'name': 'Zico', 'points': '2550'},
      {'name': 'Loopy', 'points': '2500'},
      {'name': 'Dean', 'points': '2150'},
      {'name': 'Jackson', 'points': '1920'},
      {'name': 'Nafla', 'points': '1500'},
      {'name': 'Flowsik', 'points': '100'},
    ];

    return ListView.builder(
      itemCount: rankingData.length,
      itemBuilder: (context, index) {
        final item = rankingData[index];
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 38, 40, 41),
              borderRadius: BorderRadius.circular(15), // Rounded corners
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 18, 133, 190),
                child: Text((index + 4).toString(),
                    style: const TextStyle(color: Colors.white)),
              ),
              title: Text(item['name']!,
                  style: const TextStyle(color: Colors.white)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(item['points']!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      )),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.savings_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
