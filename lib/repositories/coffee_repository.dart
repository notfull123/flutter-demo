import 'package:coffee_rosie/model/coffee.dart';
import 'package:coffee_rosie/network/api_client.dart';

abstract class CoffeeRepository {
  Future<Coffee>? getDetailCoffee();
}

class CoffeeRepositoryImpl extends CoffeeRepository {
  late ApiClient _apiClient;

  CoffeeRepositoryImpl(ApiClient client) {
    _apiClient = client;
  }

  @override
  Future<Coffee>? getDetailCoffee() async {
    return await _apiClient.getDetailCoffee();
  }
}
