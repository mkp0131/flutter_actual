import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_actual/common/const/colors.dart';
import 'package:flutter_actual/common/const/data.dart';
import 'package:flutter_actual/component/custom_text_form_field.dart';
import 'package:flutter_actual/layout/default_layout.dart';
import 'package:flutter_actual/view/root_tab.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    return DefaultLayout(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          // Drag 이벤트 발생시 키보드를 숨긴다.
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Title(),
                  _SubTitle(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3 * 2,
                    child: Image.asset(
                      'asset/img/misc/logo.png',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    hintText: '이메일을 입력해주세요.',
                    onChanged: (value) {
                      username = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    hintText: '비밀번호를 입력해주세요.',
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // 토큰으로 보낼 String
                      final rawString = '${username}:${password}';

                      // base64 인코드 디코디 할 수 있는 instance 생성
                      Codec<String, String> stringToBase64 = utf8.fuse(base64);

                      // base64로 스트링 인코드
                      final token = stringToBase64.encode(rawString);

                      final response = await dio.post(
                        'http://${ip}:3000/auth/login',
                        options: Options(
                          headers: {
                            'authorization': 'Basic ${token}',
                          },
                        ),
                      );

                      // 로그인 API 에서 받아온 토큰값
                      final accessToken = response.data['accessToken'];
                      final refreshToken = response.data['refreshToken'];

                      // 스토리지 안에 토큰을 저장
                      await storage.write(
                          key: ACCESS_TOKEN_KEY, value: accessToken);
                      await storage.write(
                          key: REFLESH_TOKEN_KEY, value: refreshToken);

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RootTab(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                    ),
                    child: Text('로그인'),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: PRIMARY_COLOR,
                    ),
                    child: Text('회원가입'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다.',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요.\n좋은 하루 보내세요 : )',
      style: TextStyle(
        color: BODY_TEXT_COLOR,
        fontSize: 16,
      ),
    );
  }
}
