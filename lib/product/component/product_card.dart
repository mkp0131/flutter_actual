import 'package:flutter/material.dart';
import 'package:flutter_actual/common/const/colors.dart';
import 'package:flutter_actual/common/const/data.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          SizedBox(
            width: 110,
            height: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'http://${ip}:3000/img/스시/중간모듬스시.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '쓰시',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
                // SizedBox(
                //   height: 5,
                // ),
                Text(
                  '쓰시 전통의 정석 입니다.쓰시 전통의 정석 입니다.쓰시 전통의 정석 입니다.쓰시 전통의 정석 입니다.쓰시 전통의 정석 입니다.쓰시 전통의 정석 입니다.쓰시 전통의 정석 입니다.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: BODY_TEXT_COLOR,
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                Text(
                  '₩ 1,000',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
