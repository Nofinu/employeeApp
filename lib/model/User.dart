class User {
  User(
    this.id,
    this.firstname,
    this.lastname,
    this.imageUrl,
    this.isAdmin,
    this.email,
    {this.token = ""}
  );
  String token;
  final int id;
  final String firstname;
  final String lastname;
  final String imageUrl;
  final bool isAdmin;
  final String email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        json['id'] as int,
        json['firstName'] as String,
        json['lastName'] as String,
        json["imageUrl"] as String,
        json['admin'] as bool,
        json['email'] as String);
  }
}
