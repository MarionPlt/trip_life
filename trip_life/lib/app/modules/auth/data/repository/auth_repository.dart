import 'package:trip_life/app/modules/auth/data/provider/auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthProvider _authProvider = AuthProvider();


  login(String email, String password) async {
    await _authProvider.signIn(email, password);
  }

  register({required String email, required String password}) async {
    await _authProvider.signUp(email: email, password: password);
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
