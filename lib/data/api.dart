import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:network_test/data/mapper.dart';
import 'package:network_test/data/model.dart';

class CatApi {
  Dio dio = Dio(BaseOptions(
      baseUrl: 'https://cat-fact.herokuapp.com',
      connectTimeout: 50000,
      receiveTimeout: 50000));
  static bool _isCached = false;

  late final DioCacheManager _cacheManager;

  CatApi() {
    _cacheManager = DioCacheManager(CacheConfig(baseUrl: dio.options.baseUrl));
    dio.interceptors.add(_cacheManager.interceptor);
  }
  Future<CatFact?> getCatFacts() async {
    try {
      final response = await dio.get('/facts/random/',
          options:
              _isCached ? buildCacheOptions(const Duration(days: 3)) : null);

      return CatFactMapper.from(response);
    } catch (_) {
      return CatFactMapper.from(null);
    }
  }

  static void toggleCacheStatus() {
    _isCached = !_isCached;
  }

  static bool isCached() => _isCached;
}
