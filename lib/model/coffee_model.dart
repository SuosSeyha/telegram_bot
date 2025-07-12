
// import 'dart:convert';

// List<CoffeeModel> coffeeModelFromJson(String str) => List<CoffeeModel>.from(json.decode(str).map((x) => CoffeeModel.fromJson(x)));

// String coffeeModelToJson(List<CoffeeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CoffeeModel {
    String title;
    String description;
    dynamic ingredients;
    String image;
    int id;

    CoffeeModel({
        required this.title,
        required this.description,
        required this.ingredients,
        required this.image,
        required this.id,
    });

    factory CoffeeModel.fromJson(Map<String, dynamic> json) => CoffeeModel(
        title: json["title"],
        description: json["description"],
        ingredients: json["ingredients"],
        image: json["image"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "ingredients": ingredients,
        "image": image,
        "id": id,
    };
}