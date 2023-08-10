class Product {
  static int _counter = 0;
  late int id;
  late String name;
  late String description;
  late double unitPrice;

  Product({
    required this.name,
    required this.description,
    required this.unitPrice,
  }) : id = ++_counter;

  Product.override({
    required this.id,
    required this.name,
    required this.description,
    required this.unitPrice,
  });

  factory Product.fromMap(Map<String, dynamic> map) => Product.override(
        id: map['id'],
        name: map['name'],
        description: map['description'],
        unitPrice: map['unitPrice'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'unitPrice': unitPrice,
    };
  }
}
