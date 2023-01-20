import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actual/common/const/colors.dart';
import 'package:flutter_actual/common/const/data.dart';
import 'package:flutter_actual/layout/default_layout.dart';
import 'package:flutter_actual/user/view/login_screen.dart';
import 'package:flutter_actual/view/root_tab.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ✅ 로그인 확인 / 토큰이 있는지 없는지 확인
    checkToken();
    // 토큰삭제
    // deleteToken();
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {
    // 스토리지에 저장된 값 변수에 저장 (값이 없다면 null 을 리턴)
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFLESH_TOKEN_KEY);

    final dio = Dio();

    // 리플레시 토큰이 없다면 return 임시로 추가함
    if (refreshToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => false,
      );
      return;
    }

    try {
      // 리플레쉬 토큰으로 새로운 토큰을 발급 요청
      final response = await dio.post(
        'http://${ip}:3000/auth/token',
        options: Options(
          headers: {
            'authorization': 'Bearer ${refreshToken}',
          },
        ),
      );

      final newAccessToken = response.data['accessToken'];
      await storage.write(key: ACCESS_TOKEN_KEY, value: newAccessToken);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => RootTab(),
        ),
        (route) => false,
      );
    } catch (e) {
      print(e);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Image.asset('asset/img/logo/logo.png'),
            ),
            SizedBox(
              height: 50,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
