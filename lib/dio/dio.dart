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
