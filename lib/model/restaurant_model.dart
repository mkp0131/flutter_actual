import 'package:flutter_actual/common/const/data.dart';
import 'package:flutter_actual/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  cheap,
  medium,
  expensive,
}

@JsonSerializable()
class RestaurantModel {
  // id
  final String id;
  // 이름
  final String name;
  // 이미지
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  // 태그
  final List<String> tags;
  // 가격 등급
  final RestaurantPriceRange priceRange;
  // 평균 평점
  final double ratings;
  // 평점 갯수
  final int ratingsCount;
  // 배송 시간
  final int deliveryTime;
  // 배송 비용
  final int deliveryFee;

  // 기본 Constructor
  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  // factory RestaurantModel.fromJson({required Map<String, dynamic> json}) {
  //   return RestaurantModel(
  //     id: json['id'],
  //     name: json['name'],
  //     thumbUrl: 'http://${ip}:3000${json['thumbUrl']}',
  //     tags: List<String>.from(json['tags']),
  //     priceRange: RestaurantPriceRange.values
  //         .firstWhere((price) => price.name == json['priceRange']),
  //     ratings: json['ratings'],
  //     ratingsCount: json['ratingsCount'],
  //     deliveryTime: json['deliveryTime'],
  //     deliveryFee: json['deliveryFee'],
  //   );
  // }
}
