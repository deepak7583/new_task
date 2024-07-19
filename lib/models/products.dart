class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  int quantity; // Added quantity field

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    this.quantity = 1, // Default quantity is 1
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      description: json['description'],
      image: json['image'],
    );
  }

  // CopyWith method for immutability
  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? image,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
    );
  }

  // Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'image': image,
    };
  }
}
