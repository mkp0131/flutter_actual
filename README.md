# flutter 실전 사용

## [flutter] class(클래스) constructor(컨스트럭터) 생성자 기본값 지정 

- 기본사용

```dart
class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;

  // ✅ 생성자 기본값 지정
  const CustomTextFormField({
    this.hintText,
    this.errText,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged,
    Key? key,
  }) : super(key: key);
```

- null 로 받고, `??` 사용

```dart
class DefaultLayout extends StatelessWidget {
  final Widget child;
  // null 로 받고, 연산자('??') 사용
  final Color? backgroundColor;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      body: child,
    );
  }
}
```

## [flutter] 문자 스트링 줄바꿈

- `\n` 을 사용한다.

```dart
Text('이메일과 비밀번호를 입력해서 로그인 해주세요.\n좋은 하루 보내세요 : )',)
```

## [flutter] input 키보드 화면을 가지지 않게 하는 법 / overflow, 화면 드레그(스크롤) 키보드 숨기기

- 해당 페이지 위젯을 SingleChildScrollView() 로 감싸준다.
- keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag 속성을 이용하면 드레기시 스크롤 숨기기도 가능

```dart
  return DefaultLayout(
      child: SingleChildScrollView(
        // Drag 이벤트 발생시 키보드를 숨긴다.
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          bottom: false,
          child: Padding(
```

## [javascript] base64 로 변경 / 인코딩 / 디코딩

- btoa(): base64로 인코딩
- atob(): base64로 디코딩

## [flutter] 안드로이드 예뮬레이터 사용시 로컬호스트 주소 / emulator

- 안드로이드 예뮬레이터의 경우에는 `10.0.2.2` 로 로컬호스트를 접근한다.
- 사용중인 플랫폼을 변수로 받아서 세팅하는 것도 가능하다.

```dart
    // localhost
    final emulatorIp = '10.0.2.2';
    final simulatorIp = '127.0.0.1';

    // 디바이스를 체크후 ip 변수를 지정
    final ip = Platform.isIOS == true ? simulatorIp : emulatorIp;
```

## [flutter] base64 로 변경 / 인코딩 / 디코딩

- base64 인코드 디코디 할 수 있는 instance 생성

```dart
final rawString = 'test@codefactory.ai:testtest';

// base64 인코드 디코디 할 수 있는 instance 생성
Codec<String, String> stringToBase64 = utf8.fuse(base64);

// base64로 스트링 인코드
final token = stringToBase64.encode(rawString);
```

## [flutter] JWT 사용법 / flutter_secure_storage 사용법

- flutter_secure_storage: ^7.0.1 를 설치한다. (https://pub.dev/packages/flutter_secure_storage)
- [project]/android/app/build.gradle 설치를 꼭 해준다.

### flutter_secure_storage

```dart
// 스토리지 안에 토큰을 저장
await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
await storage.write(key: REFLESH_TOKEN_KEY, value: refreshToken);

// 스토리지 값 읽기
final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
```

## [flutter] 리다이렉션 하고 히스토리 다지우기 라우트 삭제

- `pushAndRemoveUntil` 또는 `pushNamedAndRemoveUntil` 사용

```dart
if (accessToken == null || refleshToken == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => false,
      );
    }
```

## [flutter] bottomNavigationBar 사용법

```dart
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

    print('initState');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.removeListener(tabListener);
    print('dispose');
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
          Center(
              child: Container(
                child: Text('홈'),
              )),
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
```

## [flutter] analysis_options.yaml - rules 세팅 / 코드 린트 끄기

- lint 를 끄는 옵션이다. (더 자세한 사항은 알아봐야함.)

```yaml
  rules:
    prefer_typing_uninitialized_variables: false
    perfer_const_constructors_in_immutables: false
    prefer_const_constructors: false
    avoid_print: false  # Uncomment to disable the `avoid_print` rule
    prefer_const_literals_to_create_immutables: false
```


## [flutter] 위젯내에서 if 문 사용

- if 문 사용시 바로 밑 위젯만 영향을 받는다.
- else 문이 따로 없다!

```dart
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
```

## [flutter] border radius 사용법 

- `ClipRRect()` 위젯을 사용

```dart
SizedBox(
  width: 110,
  height: 110,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(6),
    child: Image.network(
      'http://${ip}:3000/img/스시/중간모듬스시.jpg',
      fit: BoxFit.cover,
    ),
  ),
),
```

## [flutter] 서로 다른 리스트 스크롤 만들기 / CustomScrollView

```dart
  // 커스텀 스크롤뷰
  child: CustomScrollView(
    slivers: [
      // Sliver 위젯이 아닌경우 SliverToBoxAdapter 를 감싸준다.
      SliverToBoxAdapter(
        child: RestaurantCard.fromModel(
          model: RestaurantModel.fromJson(json: item),
          isDetail: true,
          detail: '안녕하세요.\n테스트 중입니다.',
        ),
      ),
      // SliverList 위젯
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ProductCard(),
            );
          },
          // 리스트 갯수
          childCount: 10,
        )
      )
    ],
  ),
```

## [flutter] json_annotation 모델링 자동화


### 설치

- 설치 example: https://github.com/google/json_serializable.dart/tree/master/example

```js
dependencies:
  json_annotation: ^4.7.0

dev_dependencies:
  build_runner: ^2.0.0
  json_serializable: ^6.0.0
```

### 사용법

- 모델을 생성하고 싶은 클래스위에  `@JsonSerializable()` 를 붙여준다.

```dart
@JsonSerializable()
class RestaurantModel {
  // id
  final String id;
  // 이름
  final String name;
  // 이미지
```

- `part 'restaurant_model.g.dart';` 를 선언해준다
- `flutter pub run build_runner build` 를 실행한다.

### 중간에 데이터 전처리

- 전처리할 멤버변수 앞에  `@JsonKey()` 를 붙여서 전처리 세팅을 한다.

```dart
@JsonSerializable()
class RestaurantModel {
  // id
  final String id;
  // 이름
  final String name;
  // 이미지
  @JsonKey(
    fromJson: pathToUrl,
  )
  final String thumbUrl;
  // 태그
  final List<String> tags;
  // 가격 등급
  final RestaurantPriceRange priceRange;
  // 평균 평점
  final double ratings;
  // 평점 갯수
  final int ratingsCount;
  // 배송 시간
  final int deliveryTime;
  // 배송 비용
  final int deliveryFee;

  //  썸네일 전처리
  static pathToUrl(String value) {
    return 'http://${ip}:3000${value}';
  }
```

- fromJson 메소드를 다시 재정의 한다.
- 꼭 `포지셔널 파라미터`로 변경

```dart
  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);
```

## [flutter] refresh 토큰으로 재인증 / dio 인터셉트

- `dio/dio.dart` 파일 생성

```dart
import 'package:dio/dio.dart';
import 'package:flutter_actual/common/const/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  // 1. 요청
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // ✅ 요청이 보내질때마다 accessToken 을 함께 보냄
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    // ✅ 요청이 보내질때마다 refreshToken 을 함께 보냄
    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFLESH_TOKEN_KEY);

      options.headers.addAll({'authorization': 'Bearer $token'});
    }
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  // 2. 응답

  // 3. 에러
  // ✅ [토큰에러] 401 에러가 났을시
  // 토큰 재발급
  // 다시 새로운 토큰으로 재요청
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 🅰️ DEBUG: 에러 상태 출력
    // print('[ERR] [${err.requestOptions.method}] [${err.requestOptions.uri}]');

    final refreshToken = await storage.read(key: REFLESH_TOKEN_KEY);

    // print('[@ERR] [$refreshToken]');

    // refresh 토큰이 없는 겨우 에러 생성
    if (refreshToken == null) {
      return handler.reject(err);
    }

    // 코드 401 확인
    final isStatus401 = err.response?.statusCode == 401;

    // 토큰 재요청 확인
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    // print('[#ERR] [$isStatus401] [$isPathRefresh]');

    // 코드 401, but 토큰 재요청이 아닌 경우
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final response = await dio.post(
          'http://$ip:3000/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToken',
            },
          ),
        );

        final accessToken = response.data['accessToken'];

        // accessToken 새로 저장
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 기존요청 헤더
        final options = err.requestOptions;
        // 기존요청 헤더 토큰 추가
        options.headers.addAll(
          {'authorization': 'Bearer $accessToken'},
        );
        // 기존요청 헤더로 재요청
        final req = await dio.fetch(options);

        // 요청이 잘끝났다는 것을 resolve 로 전송
        return handler.resolve(req);
      } on DioError catch (e) {
        return handler.reject(e);
      }
    }

    // TODO: implement onError
    return super.onError(err, handler);
  }
}
```

- dio 에 인터셉트 추가

```dart
// Dio 인터셉트 추가
dio.interceptors.add(CustomInterceptor(storage: storage));
```


==========================
[완료] Riverpod 부터 시작해야함.
==========================