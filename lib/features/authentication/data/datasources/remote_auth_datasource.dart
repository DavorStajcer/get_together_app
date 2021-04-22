import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_together_app/core/error/exceptions.dart';
import 'package:get_together_app/features/authentication/data/models/user_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteAuthDatasource {
  Future<void> logIn(String email, String password);
  Future<void> logOut();
  Future<void> signIn(String email, String password);
/*   Future<bool> checkIsAuthenticated(); */
  Future<void> addUser(UserDataModel userDataModel);
}

class RemoteAuthDatasourceImpl extends RemoteAuthDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseStorage firebaseStorage;

  RemoteAuthDatasourceImpl({
    FirebaseAuth firebaseAuth,
    FirebaseStorage firebaseStorage,
  })  : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  @override
  Future<void> addUser(UserDataModel userDataModel) {
    throw UnimplementedError();
  }

/*   @override
  Future<bool> checkIsAuthenticated() async {} */

  @override
  Future<void> logIn(String email, String password) async {
    try {} on FirebaseAuthException catch (e) {
      throw AuthenticationException(e.code);
    }
  }

  @override
  Future<void> signIn(String email, String password) async {}

  @override
  Future<void> logOut() async {
    try {} catch (e) {
      throw AuthenticationException("sign_out_failure");
    }
  }
}
