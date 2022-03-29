class User {
  final String id;
  final String first_name;
  final String last_name;
  final String email;

  const User({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['payload']['user']['id'],
      first_name: json['payload']['user']['first_name'],
      last_name: json['payload']['user']['last_name'],
      email: json['payload']['user']['email'],
    );
  }
}

class LoginUser {
  final String email;
  final String password;

  const LoginUser({
    required this.password,
    required this.email,
  });
}

class RegisterUser {
  final String email;
  final String first_name;
  final String last_name;
  final String password;

  const RegisterUser({
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.password,
  });
}
