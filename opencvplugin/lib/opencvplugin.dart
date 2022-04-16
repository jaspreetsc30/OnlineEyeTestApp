
import 'dart:async';
import 'dart:ffi' ;
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';

final DynamicLibrary nativeLib =
    Platform.isAndroid ? DynamicLibrary.open("libopencvplugin.so") : DynamicLibrary.process();

//C function signatures
typedef _c_version = Pointer<Utf8> Function();
typedef _dart_version = Pointer<Utf8> Function();

typedef _c_mainf = Int8 Function();
typedef _dart_mainf = int Function();

typedef _c_checkerget = Double Function();
typedef _dart_checkerget = double Function();







//create dart functions that invoke the C function
//provide function name , followed by c and dart signatures
final _version = nativeLib.lookupFunction<_c_version, _dart_version>("version");
final _main = nativeLib.lookupFunction<_c_mainf , _dart_mainf>("getmessage") ;







class Opencvplugin {
  static const MethodChannel _channel = MethodChannel('opencvplugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  String cvVersion() {
    return _version().toDartString() ;

  }

  int? cvMain(){

     return  _main();
  }


}
