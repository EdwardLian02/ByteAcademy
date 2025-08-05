import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> writeData(String key, String data) async {
    await _storage.write(key: key, value: data);
  }

  Future<String?> readData(String key) async {
    String? data = await _storage.read(key: key);
    return data;
  }

  Future<void> deleteData(String key) async {
    return await _storage.delete(key: key);
  }
}
