/// Represents a user model.
class UserModel {
  final String username;

  /// Constructs a [UserModel] instance with the given [username].
  UserModel({required this.username});

  /// Constructs a [UserModel] instance from a JSON [Map].
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
    );
  }

  /// Converts this [UserModel] instance to a JSON [Map].
  Map<String, dynamic> toJson() {
    return {
      'username': username,
    };
  }
}
