import 'package:project1/services/auth/auth_provider.dart';
import 'package:project1/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {}

class MockOfAuthProvider implements AuthProvider {


  @override
  Future<AuthUser> createUser(
      {required String email, required String password}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }



  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }
}
