import 'package:coffee_rosie/model/topping.dart';

class Coffee {
  List<Topping>? toppings;
  String? name;
  String? price;
  String? description;
  String? avatar;

  Coffee({this.toppings, this.name, this.price, this.description, this.avatar});

  Coffee.fromJson(Map<String, dynamic> json) {
    if (json['toppings'] != null) {
      toppings = <Topping>[];
      json['toppings'].forEach((v) {
        toppings!.add(Topping.fromJson(v));
      });
    }
    name = json['name'];
    price = json['price'];
    description = json['description'];
    avatar = json['avatar'];
  }
}
