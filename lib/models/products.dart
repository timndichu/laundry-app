class Product {
  final num id;
  final String title;
  final String image;
  final num price;
  final String service;

  Product({
    this.title,
    this.id,
    this.image,
    this.price,
    this.service,
  });

  Map toJson() => {
        'id': id,
        'title': title,
        'image': image,
        'price': price,
        'service': service,
      };
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        price: json['price'],
        service: json['service'],
      );
}
