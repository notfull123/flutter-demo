import 'package:coffee_rosie/model/coffee.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://622a245fbe12fc4538b36a4f.mockapi.io")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/api/v1/coffeeDetail/DetailCoffee/100')
  Future<Coffee> getDetailCoffee();
}
