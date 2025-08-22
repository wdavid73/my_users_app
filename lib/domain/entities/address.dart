class Address {
  final String name;

  const Address({
    required this.name,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is Address &&
           other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
