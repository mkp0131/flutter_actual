import 'package:flutter/material.dart';
import 'package:flutter_actual/common/const/colors.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      appBar: renderAppbar(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? renderAppbar() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        // 배경 색상
        backgroundColor: Colors.white,
        // 타이틀 색상(켄텐츠 색상)
        foregroundColor: PRIMARY_COLOR,
        // AppBar 그림자 효과
        elevation: 0,
        // 타이틀
        title: Text(
          title!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        // 타이틀 가운데 정렬
        centerTitle: true,
      );
    }
  }
}
