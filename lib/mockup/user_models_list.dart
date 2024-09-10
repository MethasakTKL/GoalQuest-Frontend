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
  User(
    id: 5,
    first_name: 'David',
    last_name: 'David',
    username: 'David',
    email: 'david.d@email.com',
    point: 1600,
    image: 'assets/user_image.png',
  ),
  User(
    id: 6,
    first_name: 'Eva',
    last_name: 'Eva',
    username: 'Eva',
    email: 'eva.e@email.com',
    point: 1500,
    image: 'assets/user_image.png',
  ),
  User(
    id: 7,
    first_name: 'Frank',
    last_name: 'Frank',
    username: 'Frank',
    email: 'frank.f@email.com',
    point: 1400,
    image: 'assets/user_image.png',
  ),
  User(
    id: 8,
    first_name: 'Grace',
    last_name: 'Grace',
    username: 'Grace',
    email: 'grace.g@email.com',
    point: 1300,
    image: 'assets/user_image.png',
  ),
  User(
    id: 9,
    first_name: 'Hank',
    last_name: 'Hank',
    username: 'Hank',
    email: 'hank.h@email.com',
    point: 1200,
    image: 'assets/user_image.png',
  ),
  User(
    id: 10,
    first_name: 'Ivy',
    last_name: 'Ivy',
    username: 'Ivy',
    email: 'ivy.i@email.com',
    point: 1100,
    image: 'assets/user_image.png',
  ),
  User(
    id: 11,
    first_name: 'Jack',
    last_name: 'Jack',
    username: 'Jack',
    email: 'jack.j@email.com',
    point: 1000,
    image: 'assets/user_image.png',
  ),
];

  