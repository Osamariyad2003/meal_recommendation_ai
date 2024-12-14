import 'package:hive/hive.dart';
import 'package:meal_recommendation_ai/core/models/user.dart';

import 'meal.dart';

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 4; // Unique ID for the User adapter

  @override
  User read(BinaryReader reader) {
    // Read the number of fields
    final numOfFields = reader.readByte();
    // Map each field index to its value
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    // Create a User instance using the fields
    return User(
      userId: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      meals: (fields[3] as List).cast<Meal>(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    // Write the number of fields
    writer
      ..writeByte(4) // Number of fields in User class
      ..writeByte(0) // Field 0: userId
      ..write(obj.userId)
      ..writeByte(1) // Field 1: name
      ..write(obj.name)
      ..writeByte(2) // Field 2: email
      ..write(obj.email)
      ..writeByte(3) // Field 3: meals
      ..write(obj.meals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
