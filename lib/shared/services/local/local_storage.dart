import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:focus/shared/utils/app_constant.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage{
  LocalStorage._(){
    _storage = const FlutterSecureStorage();
    _box = _initSecureBox;
  }

  static LocalStorage get instance => LocalStorage._();

  late final FlutterSecureStorage _storage;
  late final Future<Box> _box;

  Future<Box> get _initSecureBox async{
    String encryptedKey = await _storage.read(key: AppConstant.encryptedKey) ?? '';

    if(encryptedKey.isEmpty){
      final key = Hive.generateSecureKey();
      await _storage.write(key: AppConstant.encryptedKey, value: base64UrlEncode(key));
      encryptedKey = (await _storage.read(key: AppConstant.encryptedKey))!;
    }

    final encryptionKeyUint8List = base64Url.decode(encryptedKey);
    return await Hive.openBox(AppConstant.box, encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  }

  Future<void> setData<T>(String key, T value)async{
    (await _box).put(key, value);
  }

  Future<bool> get appEntry async => (await _box).get(AppConstant.appEntry) ?? false;
}