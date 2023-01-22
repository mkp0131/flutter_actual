import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_actual/common/model/cursor_pagination_model.dart';
import 'package:flutter_actual/model/restaurant_detail_model.dart';
import 'package:flutter_actual/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

// RestApi - RestaurantRepository 생성
@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  // 메소드로 라우트틑 생성한다.
  // http://$ip/restaurant
  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate();

  // http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });
}
