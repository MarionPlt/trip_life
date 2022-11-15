import 'package:trip_life/app/modules/auth/data/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthProvider _authProvider = AuthProvider();


  Future<UserCredential> login(String email, String password) async {
    return await _authProvider.signIn(email, password);
  }

  Future<UserCredential> register({required String email, required String password}) async {
    return await _authProvider.signUp(email: email, password: password);
  }

  disconnect() async {
    await _authProvider.signOut();
  }

  User? getCurrentUser() {
    return _authProvider.getCurrentUser();
  }

  resetPassword({required String email}) {
    return _authProvider.resetPassword(email);
  }
}
