class MyUser {
  final String firstName;
  final String lastName;
  final DateTime dateBirth;

  const MyUser({
    required this.firstName,
    required this.lastName,
    required this.dateBirth,
  });

  /// Returns the date in 'yyyy-MM-dd' format
  String get formattedDate => '${dateBirth.year}-${dateBirth.month.toString().padLeft(2, '0')}-${dateBirth.day.toString().padLeft(2, '0')}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is MyUser &&
           other.firstName == firstName &&
           other.lastName == lastName &&
           other.dateBirth == dateBirth;
  }

  @override
  int get hashCode => Object.hash(firstName, lastName, dateBirth);
}
