import 'package:my_users_app/data/models/address_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddressModel', () {
    test('creates an instance correctly', () {
      final address = AddressModel(name: 'Calle 123');
      expect(address.name, 'Calle 123');
    });

    test('two instances with the same value are equal', () {
      final a1 = AddressModel(name: 'Calle 123');
      final a2 = AddressModel(name: 'Calle 123');

      expect(a1, equals(a2));
    });

    test('two instances with different values are not equal', () {
      final a1 = AddressModel(name: 'Calle 123');
      final a2 = AddressModel(name: 'Avenida 456');

      expect(a1 == a2, false);
    });
  });
}
