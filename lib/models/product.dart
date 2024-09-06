class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;
  final double rating;
  final String brand;
  final String? color;
  final String? connectivity;
  final bool? wireless;
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.brand,
    this.color,
    this.connectivity,
    this.wireless,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"].toDouble(),
        image: json["image"],
        rating: json["rating"].toDouble(),
        brand: json["brand"],
        color: json["color"],
        connectivity: json["connectivity"],
        wireless: json["wireless"],
      );
}
