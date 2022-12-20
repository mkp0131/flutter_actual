import 'package:flutter/material.dart';
import 'package:flutter_actual/common/const/colors.dart';
import 'package:flutter_actual/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  // 이미지
  final Widget image;
  // 이름
  final String name;
  // 태그
  final List<String> tags;
  // 평점 갯수
  final int ratingsCount;
  // 평균 평점
  final double ratings;
  // 배송 시간
  final int deliveryTime;
  // 배송 비용
  final int deliveryFee;
  // 디테일 페이지 여부
  bool isDetail;
  // 디테일 페이지 설명 글
  final String? detail;

  RestaurantCard({
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.ratings,
    required this.deliveryTime,
    required this.deliveryFee,
    this.isDetail = false,
    this.detail,
    Key? key,
  }) : super(key: key);

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
    String? detail,
  }) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      ratings: model.ratings,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      isDetail: isDetail,
      detail: detail,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!this.isDetail)
          // ClipRRect(): border-radius 로 깍고싶을경우 사용
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: image,
          ),
        if (this.isDetail) image,
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: this.isDetail
              ? const EdgeInsets.symmetric(horizontal: 8.0)
              : const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                tags.join(' · '),
                style: TextStyle(
                  color: BODY_TEXT_COLOR,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  _IconText(
                    icon: Icons.star,
                    label: ratings.toString(),
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.receipt,
                    label: ratingsCount.toString(),
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.timelapse_outlined,
                    label: '${deliveryTime} 분',
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.monetization_on,
                    label:
                        '${deliveryFee == 0 ? '무료' : deliveryFee.toString()}',
                  ),
                ],
              ),
              // 디테일 페이지 & 디테일 텍스트가 있을시 랜더
              if (this.detail != null && this.isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(detail!),
                )
            ],
          ),
        ),
      ],
    );
  }

  Widget renderDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        ' · ',
        style: TextStyle(
          color: BODY_TEXT_COLOR,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({
    required this.icon,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 16,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          label,
          style: TextStyle(
            color: BODY_TEXT_COLOR,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
