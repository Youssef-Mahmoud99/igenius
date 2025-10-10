import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    try {
      // أولًا نشوف نوع الاتصال
      final result = await connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) return false;

      // بعدين نجرب نعمل ping لموقع موثوق
      final resultPing = await InternetAddress.lookup('example.com');
      return resultPing.isNotEmpty && resultPing[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }
}
