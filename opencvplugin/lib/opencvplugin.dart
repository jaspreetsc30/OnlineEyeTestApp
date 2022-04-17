
import 'dart:async';
import 'dart:ffi' ;
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

final DynamicLibrary nativeLib =
    Platform.isAndroid ? DynamicLibrary.open("libopencvplugin.so") : DynamicLibrary.process();

//C function signatures
typedef _c_version = Pointer<Utf8> Function();
typedef _dart_version = Pointer<Utf8> Function();

typedef _c_mainf = Int8 Function(Pointer<Utf8>);
typedef _dart_mainf = int Function(Pointer<Utf8>);

typedef _c_checkerget = Double Function();
typedef _dart_checkerget = double Function();

typedef _c_refimage = Double Function(Int32 width ,Int32 height , Int32 rotation , Pointer<Uint8> bytes ,Int32 isYUV , Pointer<Utf8> path);
typedef _dart_refimage = double Function(int width ,int height , int rotation , Pointer<Uint8> bytes, int isYUV  , Pointer<Utf8> path);

typedef _c_getdistance = Double Function(Int32 width ,Int32 height , Int32 rotation , Pointer<Uint8> bytes ,Int32 isYUV , Pointer<Utf8> path , Double computedFocalLength);
typedef _dart_getdistance = double Function(int width ,int height , int rotation , Pointer<Uint8> bytes, int isYUV  , Pointer<Utf8> path, double computedFocalLength);



//create dart functions that invoke the C function
//provide function name , followed by c and dart signatures
final _version = nativeLib.lookupFunction<_c_version, _dart_version>("version");
final _main = nativeLib.lookupFunction<_c_mainf , _dart_mainf>("getmessage") ;
final _refimage = nativeLib.lookupFunction<_c_refimage , _dart_refimage>("refimage");
final _getdistance = nativeLib.lookupFunction<_c_getdistance,_dart_getdistance>("getdistance");





class Opencvplugin {
  static const MethodChannel _channel = MethodChannel('opencvplugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  String cvVersion() {
    return _version().toDartString() ;

  }

  int? cvMain(String path){

    final fooNative = path.toNativeUtf8();
    int result = _main(fooNative);
    malloc.free(fooNative);
    return result;
  }


  double? getref(int width ,int height ,int rotation , Uint8List yBuffer, Uint8List? uBuffer, Uint8List? vBuffer ,String path){
    final fooNative = path.toNativeUtf8();

    var ySize = yBuffer.lengthInBytes;
    var uSize = uBuffer?.lengthInBytes ?? 0;
    var vSize = vBuffer?.lengthInBytes ?? 0;
    var totalSize = ySize + uSize + vSize;

    Pointer<Uint8> imageBuffer = malloc.allocate<Uint8>(totalSize);

    // We always have at least 1 plane, on Android it si the yPlane on iOS its the rgba plane
    Uint8List _bytes = imageBuffer.asTypedList(totalSize);
    _bytes.setAll(0, yBuffer);

    if (Platform.isAndroid) {
      // Swap u&v buffer for opencv
      _bytes.setAll(ySize, vBuffer!);
      _bytes.setAll(ySize + vSize, uBuffer!);
    }



    double focallength = _refimage(width, height, rotation, imageBuffer, Platform.isAndroid ? 1 : 0, fooNative);
    malloc.free(fooNative) ;
    malloc.free(imageBuffer);
    return focallength;

  }



  double? getdistance(int width ,int height ,int rotation , Uint8List yBuffer, Uint8List? uBuffer, Uint8List? vBuffer ,String path , double computedFocalLength){
    final fooNative = path.toNativeUtf8();

    var ySize = yBuffer.lengthInBytes;
    var uSize = uBuffer?.lengthInBytes ?? 0;
    var vSize = vBuffer?.lengthInBytes ?? 0;
    var totalSize = ySize + uSize + vSize;

    Pointer<Uint8> imageBuffer = malloc.allocate<Uint8>(totalSize);

    // We always have at least 1 plane, on Android it si the yPlane on iOS its the rgba plane
    Uint8List _bytes = imageBuffer.asTypedList(totalSize);
    _bytes.setAll(0, yBuffer);

    if (Platform.isAndroid) {
      // Swap u&v buffer for opencv
      _bytes.setAll(ySize, vBuffer!);
      _bytes.setAll(ySize + vSize, uBuffer!);
    }



    double distance = _getdistance(width, height, rotation, imageBuffer, Platform.isAndroid ? 1 : 0, fooNative,computedFocalLength);
    malloc.free(fooNative) ;
    malloc.free(imageBuffer);
    return distance;







  }



}
