import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:opencvplugin/opencvplugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('opencvplugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Opencvplugin.platformVersion, '42');
  });
}
