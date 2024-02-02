class PetModel {
  final int id;
  final String name;
  final String age;
  final String price;
  final String image;
  final String category;

  PetModel({
    required this.id,
    required this.name,
    required this.age,
    required this.price,
    required this.image,
    required this.category,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      price: json['price'],
      image: json['image'],
      category: json['category'],
    );
  }
}
