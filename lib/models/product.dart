class Product {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] is int
          ? json["id"]
          : int.parse(json["id"].toString()),

      title: json["title"] ?? "",
      description: json["description"] ?? "",

      price: (json["price"] as num).toDouble(),

      thumbnail: (json["images"] != null &&
              json["images"] is List &&
              json["images"].isNotEmpty)
          ? json["images"][0]
          : (json["thumbnail"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "price": price,
      "thumbnail": thumbnail,
    };
  }
}