import 'package:flutter_starter_kit/data/models/my_user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MyUserModel', () {
    test('fromJson creates an instance correctly with DateTime', () {
      final json = {
        "first_name": "Juan",
        "last_name": "Pérez",
        "date_birth": DateTime(1995, 5, 20),
      };

      final user = MyUserModel.fromJson(json);

      expect(user.firstName, 'Juan');
      expect(user.lastName, 'Pérez');
      expect(user.formattedDate, '1995-05-20');
    });

    test('fromJson creates an instance correctly with String date', () {
      final json = {
        "first_name": "Juan",
        "last_name": "Pérez",
        "date_birth": "1995-05-20",
      };

      final user = MyUserModel.fromJson(json);

      expect(user.firstName, 'Juan');
      expect(user.lastName, 'Pérez');
      expect(user.formattedDate, '1995-05-20');
    });

    test('fullName returns concatenated name correctly', () {
      final user = MyUserModel(
        firstName: 'Ana',
        lastName: 'López',
        dateBirth: DateTime(2000, 1, 1),
      );

      expect(user.fullName, 'Ana López');
    });

    test('two instances with the same values are equal', () {
      final user1 = MyUserModel(
        firstName: 'Pedro',
        lastName: 'Gómez',
        dateBirth: DateTime(1990, 12, 12),
      );

      final user2 = MyUserModel(
        firstName: 'Pedro',
        lastName: 'Gómez',
        dateBirth: DateTime(1990, 12, 12),
      );

      expect(user1, equals(user2));
      expect(user1.hashCode, equals(user2.hashCode));
    });

    test('two instances with different values are not equal', () {
      final user1 = MyUserModel(
        firstName: 'Carlos',
        lastName: 'Méndez',
        dateBirth: DateTime(1980, 1, 1),
      );

      final user2 = MyUserModel(
        firstName: 'Luis',
        lastName: 'Méndez',
        dateBirth: DateTime(1980, 1, 1),
      );

      expect(user1 == user2, false);
    });
  });
}
