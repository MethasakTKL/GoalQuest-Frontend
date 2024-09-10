class UserRankings {
  final int id;
  final String username;
  final int point;
  final String image;

  UserRankings(
      {required this.id,
      required this.username,
      required this.point,
      required this.image});
}

List<UserRankings> userRankingsList = [
  UserRankings(
      id: 2,
      username: 'Steven',
      point: 2000,
      image: 'assets/mockup/rank_1.png'),
  UserRankings(
      id: 3,
      username: 'Deadpool',
      point: 1800,
      image: 'assets/mockup/rank_2.png'),
  UserRankings(
      id: 4,
      username: 'Loki',
      point: 1700,
      image: 'assets/mockup/rank_3.png'),
  ];