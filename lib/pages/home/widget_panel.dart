import 'package:flutter/material.dart';
import 'package:goal_quest/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeWidgetPanel extends StatefulWidget {
  const HomeWidgetPanel({Key? key}) : super(key: key);

  @override
  _HomeWidgetPanelState createState() => _HomeWidgetPanelState();
}

class _HomeWidgetPanelState extends State<HomeWidgetPanel> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pointState = context.read<PointBloc>().state;
    if (pointState is! ReadyPointState) {
      context.read<PointBloc>().add(LoadAllPointsEvent());
    }

    // ตรวจสอบว่า UserState ไม่ใช่ ReadyUserState เพื่อป้องกันการโหลดข้อมูลซ้ำ
    final userState = context.read<UserBloc>().state;
    if (userState is! ReadyUserState) {
      context.read<UserBloc>().add(GetAllUsersEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    // นับจำนวน Goals จาก Bloc
    final goalsCount =
        context.select((GoalBloc bloc) => bloc.state.goals.length);

    return Row(
      children: [
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 213, 69, 69),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      '$goalsCount', // ใช้จำนวน Goals ที่ได้จาก Bloc
                      style: const TextStyle(
                        fontFamily: 'Barlow',
                        fontSize: 55, // Larger size for points
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'GOALS',
                    style: TextStyle(
                      fontFamily: 'Barlow',
                      fontSize: 20, // Adjusted size for smaller text
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 141, 66, 245),
                  Color(0xFF0D47A1),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                  return BlocBuilder<PointBloc, PointState>(
                    builder: (context, pointState) {
                      if (pointState is ReadyPointState) {
                        final currentUserPoint = pointState.points.firstWhere(
                        (point) => point.userId == state.user.id,
                        );
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 45),
                              child: Text(
                                'TOTAL POINT',
                                style: TextStyle(
                                  fontFamily: 'Barlow',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 233, 233, 233),
                                ),
                              ),
                            ),
                            Text(
                              '${currentUserPoint.totalPoint}',
                              style: const TextStyle(
                                fontFamily: 'Barlow',
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        );
                      }
                      return const CircularProgressIndicator(); // แสดง loading indicator ถ้าข้อมูลยังไม่โหลดเสร็จ
                    },
                  );
                
                return Container();
              },
            ),
          ),
        ),
      ],
    );
  }
}
