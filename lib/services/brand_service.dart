import 'package:fashion_assistant/models/brand.dart';
import 'package:fashion_assistant/utils/http/http_client.dart';

class BrandService {
  static const String baseUrl = 'api/brand';

  Future<List<Brand>> fetchBrands() async {
    final response = await HttpHelper.get(baseUrl);

    List<dynamic> brandsJson = response['brands'] as List<dynamic>;
    return brandsJson.map((json) => Brand.fromJson(json)).toList();
  }
}
