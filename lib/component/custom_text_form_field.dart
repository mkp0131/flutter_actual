import 'package:flutter/material.dart';
import 'package:flutter_actual/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    this.hintText,
    this.errText,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: INPUT_BORDER_COLOR,
        width: 1,
      ),
    );

    return TextFormField(
      // 값이 변경될때마다 실행 이벤트
      onChanged: onChanged,
      // 비밀번호 입력시, 입력 텍스트 암호화
      obscureText: obscureText,
      // 화면이 로드 되었을시 바로 포커스
      autofocus: autofocus,
      // 커서 색상
      cursorColor: PRIMARY_COLOR,
      // input 스타일 지정
      decoration: InputDecoration(
        // input 의 패딩
        contentPadding: EdgeInsets.all(10),
        // 배경 컬러 설정(boolean)
        filled: true,
        // 배경 컬러 지정
        fillColor: INPUT_BG_COLOR,
        // 기본상태 라인 (기본값은 UnderlineInputBorder() 이다 / 아래에만 border 생성)
        border: baseBorder, // 기본 보더 상태 아래 줄을 없앰
        enabledBorder: baseBorder, // 활성화된 상태에서 보더 상태 아래 줄을 없앰
        // 포커스상태 라인
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
        // hintText => placeholder
        hintText: hintText,
        // hintText Style 지정
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14,
        ),
        // 에러가 났을시 메세지 입력(정상상태 null)
        errorText: errText,
      ),
    );
  }
}
