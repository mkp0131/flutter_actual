import 'package:flutter/material.dart';
import 'package:flutter_actual/layout/default_layout.dart';
import 'package:flutter_actual/model/restaurant_model.dart';
import 'package:flutter_actual/product/component/product_card.dart';
import 'package:flutter_actual/restaurant/component/restaurant_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> item = {
      "id": "4729bd37-8927-5150-b036-395da7e7bb42",
      "name": "신선 코팩 스시",
      "thumbUrl": "/img/스시/중간모듬스시.jpg",
      "tags": ["스시", "일식", "연어"],
      "priceRange": "expensive",
      "ratings": 4.52,
      "ratingsCount": 100,
      "deliveryTime": 30,
      "deliveryFee": 0
    };

    return DefaultLayout(
      title: '불타는 떡볶이',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RestaurantCard.fromModel(
            model: RestaurantModel.fromJson(json: item),
            isDetail: true,
            detail: '안녕하세요.\n테스트 중입니다.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ProductCard(),
          ),
        ],
      ),
    );
  }
}
