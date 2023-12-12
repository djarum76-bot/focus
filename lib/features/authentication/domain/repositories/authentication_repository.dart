abstract class AuthenticationRepository{
  Future<bool> readAppEntry();
  Future<void> writeAppEntry();
}