import 'package:flutter/material.dart';
import 'package:flutter_actual/common/const/colors.dart';
import 'package:flutter_actual/layout/default_layout.dart';
import 'package:flutter_actual/restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({Key? key}) : super(key: key);

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  int pageIndex = 0;
  // 나중에 값이 입력이 꼭 된다면 ? 가 아닌 late 를 선언해준다.
  // late 의 장점 null 체크를 피할 수 있다.
  // 탭 컨트롤러
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 클래스에 width SingleTickerProviderStateMixin 해준다. (vsync 에서 필요)
    tabController = TabController(length: 4, vsync: this);
    // tabController 에 이벤트를 건다.
    tabController.addListener(tabListener);

    // print('initState');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.removeListener(tabListener);
    // print('dispose');
    super.dispose();
  }

  // 탭컨트롤러 이벤트
  void tabListener() {
    setState(() {
      pageIndex = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: TabBarView(
        // 탭이 스크롤로 전화되는 것 막기
        physics: NeverScrollableScrollPhysics(),
        // 탭 이동시 컨트롤러
        controller: tabController,
        children: [
          RestaurantScreen(),
          Center(
              child: Container(
            child: Text('음식'),
          )),
          Center(
              child: Container(
            child: Text('주문'),
          )),
          Center(
              child: Container(
            child: Text('프로필'),
          )),
        ],
      ),
      title: '딜리버리',
      bottomNavigationBar: BottomNavigationBar(
        // 선택 생상
        selectedItemColor: PRIMARY_COLOR,
        // 기본 생상
        unselectedItemColor: BODY_TEXT_COLOR,
        // 선택 폰트 크기
        selectedFontSize: 10,
        // 기본 폰트 크기
        unselectedFontSize: 10,
        // 엑티브 에니메이션 타입 (기본: shifting / fixed 로 사용!)
        type: BottomNavigationBarType.fixed,
        // 메뉴를 탭했을시
        onTap: (index) {
          // 탭 컨트롤러를 움직임
          tabController.animateTo(index);
        },
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_outlined),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
