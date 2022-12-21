import 'package:flutter_actual/common/const/data.dart';
import 'package:flutter_actual/model/restaurant_model.dart';

class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson({required Map<String, dynamic> json}) {
    return RestaurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://${ip}:3000${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values
          .firstWhere((price) => price.name == json['priceRange']),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      products: json['products']
          .map<RestaurantProductModel>(
            (product) => RestaurantProductModel.fromJson(
              json: product,
            ),
          )
          .toList(),
    );
  }
}

class RestaurantProductModel {
  final String id;
  final String name;
  final String detail;
  final String imgUrl;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
  });

  factory RestaurantProductModel.fromJson(
      {required Map<String, dynamic> json}) {
    return RestaurantProductModel(
      id: json['id'],
      name: json['name'],
      detail: json['detail'],
      imgUrl: 'http://${ip}:3000${json['imgUrl']}',
      price: json['price'],
    );
  }
}