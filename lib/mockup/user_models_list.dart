class User {
  final int id;
  final String first_name;
  final String last_name;
  final String username;
  final String email;
  final int point;
  final String image;

  User(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.username,
      required this.email,
      required this.point,
      required this.image});
}

List<User> usersList = [
  User(
      id: 1,
      first_name: 'Wade',
      last_name: 'Wilson',
      username: 'deadpool24',
      email: 'wade.w@email.com',
      point: 1000,
      image: 'assets/user_image.png'),
];
