
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/response/products_response.dart';

part 'products_endpoint.g.dart';

@RestApi()
abstract class ProductsEndpoint {
  factory ProductsEndpoint(Dio dio, {String baseUrl}) = _ProductsEndpoint;

  /*@GET('/products/{page}.json')
  Future<ProductsResponse> getProducts(@Path("page") int page);
*/
  @GET('/products/{page}.json')
  Future<ProductsResponse> getProducts(@Path("page") int page);
}
