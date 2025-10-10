import 'package:get_storage/get_storage.dart';

import '../../injection/service_locator.dart';

class GetStorageService {
    static GetStorage storage = sl<GetStorage>();
 static Future<void> write(String key, dynamic value) async {
    await storage .write(key, value);
  }

  /// Read value
static  T? read<T>(String key) {
    return storage.read<T>(key);
  }

  /// Remove value
static  Future<void> remove(String key) async {
    await storage.remove(key);
  }

  /// Clear all
 static Future<void> clear() async {
    await storage.erase();
  }

  /// Check if contains a key
 static bool contains(String key) {
    return storage.hasData(key);
  }
}
