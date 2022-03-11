import 'package:coffee_rosie/ui/detail_coffee.dart';

class Topping {
  String? name;
  String? price;
  String? type;

  Topping({this.name, this.price, this.type});

  Topping.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    type = json['type'];
  }

  ToppingCharacter? get getDestinationType {
    return ToppingCharacterExtension.fromType(type);
  }
}
