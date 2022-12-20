import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFLESH_TOKEN_KEY = 'REFLESH_TOKEN';

// 스토리지 instance
final storage = new FlutterSecureStorage();

// localhost
final emulatorIp = '10.0.2.2';
final simulatorIp = '127.0.0.1';

// 디바이스를 체크후 ip 변수를 지정
final ip = Platform.isIOS == true ? simulatorIp : emulatorIp;
