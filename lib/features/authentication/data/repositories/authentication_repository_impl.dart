import 'package:focus/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:focus/shared/services/local/local_storage.dart';
import 'package:focus/shared/utils/app_constant.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository{
  final LocalStorage _storage = LocalStorage.instance;

  @override
  Future<bool> readAppEntry()async{
    try{
      return await _storage.appEntry;
    }catch(_){
      return false;
    }
  }

  @override
  Future<void> writeAppEntry()async{
    try{
      await _storage.setData(AppConstant.appEntry, true);
    }catch(_){
      await _storage.setData(AppConstant.appEntry, false);
    }
  }
}