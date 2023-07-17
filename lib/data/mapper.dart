import 'package:dio/dio.dart';
import 'package:network_test/data/model.dart';

abstract class CatFactMapper {
  static CatFact from(
    Response? response,
  ) {
    return CatFact(response?.data['text'] ?? 'bad request',
        'https://http.cat/${response?.statusCode ?? '404'}');
  }
}
