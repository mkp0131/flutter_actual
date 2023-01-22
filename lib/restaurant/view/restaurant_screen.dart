import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actual/common/const/data.dart';
import 'package:flutter_actual/dio/dio.dart';
import 'package:flutter_actual/model/restaurant_model.dart';
import 'package:flutter_actual/repository/restaurant_repository.dart';
import 'package:flutter_actual/restaurant/component/restaurant_card.dart';
import 'package:flutter_actual/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List<RestaurantModel>> paginateRestaurant() async {
    final dio = Dio();

    dio.interceptors.add(
      CustomInterceptor(storage: storage),
    );

    final resq =
        await RestaurantRepository(dio, baseUrl: 'http://$ip:3000/restaurant')
            .paginate();

    return resq.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List<RestaurantModel>>(
            future: paginateRestaurant(),
            builder: (context, snapshot) {
              // print('⛔️ error ${snapshot.error}');
              // print('✅ ${snapshot.data}');

              // [개발용] 데이터가 없으면 빈 화면
              if (!snapshot.hasData) {
                return Container();
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                  final pItem = snapshot.data![index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RestaurantDetailScreen(id: pItem.id),
                        ),
                      );
                    },
                    child: RestaurantCard.fromModel(
                      model: pItem,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 20,
                    // color: Colors.red,
                  );
                },
                itemCount: snapshot.data!.length,
              );
            }),
      ),
    );
  }
}
