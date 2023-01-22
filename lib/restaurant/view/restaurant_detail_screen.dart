import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actual/common/const/data.dart';
import 'package:flutter_actual/dio/dio.dart';
import 'package:flutter_actual/layout/default_layout.dart';
import 'package:flutter_actual/model/restaurant_detail_model.dart';
import 'package:flutter_actual/model/restaurant_model.dart';
import 'package:flutter_actual/product/component/product_card.dart';
import 'package:flutter_actual/repository/restaurant_repository.dart';
import 'package:flutter_actual/restaurant/component/restaurant_card.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;

  const RestaurantDetailScreen({
    required this.id,
    Key? key,
  }) : super(key: key);

  Future<RestaurantDetailModel> getRestaurantDetail() async {
    final dio = Dio();

    // Dio 인터셉트 추가
    dio.interceptors.add(CustomInterceptor(storage: storage));

    final repository =
        RestaurantRepository(dio, baseUrl: 'http://${ip}:3000/restaurant');

    return repository.getRestaurantDetail(id: id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RestaurantDetailModel>(
      future: getRestaurantDetail(),
      builder: (_, AsyncSnapshot<RestaurantDetailModel> snapshot) {
        // if (snapshot.hasError) {
        //   return Scaffold(
        //     body: Text(snapshot.error.toString()),
        //   );
        // }

        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return DefaultLayout(
          title: snapshot.data!.name,
          // 커스텀 스크롤뷰
          child: CustomScrollView(
            slivers: [
              renderTop(model: snapshot.data!),
              renderLable(),
              renderProducts(products: snapshot.data!.products),
            ],
          ),
        );
      },
    );
  }

  renderTop({
    required RestaurantDetailModel model,
  }) {
    // Sliver 위젯이 아닌경우 SliverToBoxAdapter 를 감싸준다.
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  renderProducts({required List<RestaurantProductModel> products}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = products[index];
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ProductCard.fromModel(model: model),
            );
          },
          // 리스트 갯수
          childCount: products.length,
        ),
      ),
    );
  }

  renderLable() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
