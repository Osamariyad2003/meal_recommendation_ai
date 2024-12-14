import 'meal.dart';

class User {
  final String userId;
  final String name;
  final String email;
  final List<Meal> meals;

  User({
    required this.userId,
    required this.name,
    required this.email,
    this.meals = const [],
  });

  User copyWith({
    String? userId,
    String? name,
    String? email,
    List<Meal>? meals,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      meals: meals ?? this.meals,
    );
  }

  @override
  String toString() {
    return 'User(userId: $userId, name: $name, email: $email, meals: $meals)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.userId == userId &&
        other.name == name &&
        other.email == email &&
        other.meals == meals;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
    name.hashCode ^
    email.hashCode ^
    meals.hashCode;
  }
}
