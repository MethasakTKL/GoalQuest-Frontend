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
      id: 1,
      username: 'Steven',
      point: 2000,
      image: 'assets/mockup/rank_1.png'),
  UserRankings(
      id: 2,
      username: 'Deadpool',
      point: 1800,
      image: 'assets/mockup/rank_2.png'),
  UserRankings(
      id: 3,
      username: 'Loki',
      point: 1700,
      image: 'assets/mockup/rank_3.png'),
  UserRankings(
      id: 4,
      username: 'David',
      point: 1600,
      image: 'assets/user_image.png'),
  UserRankings(
      id: 5,
      username: 'Eva',
      point: 1500,
      image: 'assets/user_image.png'),
  UserRankings(
      id: 6,
      username: 'Frank',
      point: 1400,
      image: 'assets/user_image.png'),
  UserRankings(
      id: 7,
      username: 'Grace',
      point: 1300,
      image: 'assets/user_image.png'),
  UserRankings(
      id: 8,
      username: 'Hank',
      point: 1200,
      image: 'assets/user_image.png'),
  UserRankings(
      id: 9,
      username: 'Ivy',
      point: 1100,
      image: 'assets/user_image.png'),
  UserRankings(
      id: 10,
      username: 'Jack',
      point: 1000,
      image: 'assets/user_image.png'),
  ];