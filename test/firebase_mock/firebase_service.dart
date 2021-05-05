//@dart=2.6

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

import 'firebase_auth_mock.dart';
import 'firebase_firestore_mock.dart';
import 'firebase_mocked_classes.dart';
import 'firebase_storage_mock.dart';

class FirebaseService {
  //Services
  final FirebaseAuthMock firebaseAuthMock = FirebaseAuthMock();
  final FirebaseStorageMock firebaseStorageMock = FirebaseStorageMock();
  final FirebaseFirestoreMock firebaseFirestoreMock = FirebaseFirestoreMock();
  //Firebase classes
  final UserCredentialsMock userCredentialsMock = UserCredentialsMock();
  final CollectionReferenceMock collectionReferenceMock =
      CollectionReferenceMock();
  final DocumentReferenceMock documentReferenceMock = DocumentReferenceMock();
  final UploadTaskMock uploadTaskMock = UploadTaskMock();
  final ReferenceMock referenceMock = ReferenceMock();
  final UserMock userMock = UserMock();
  //Test values
  static const String tDownloadUrl = "tDownloadUrl";

  FirebaseService() {
    when(userMock.uid).thenAnswer((realInvocation) => "tUserId");
    when(referenceMock.child(any))
        .thenAnswer((realInvocation) => referenceMock);
    when(documentReferenceMock.set(any))
        .thenAnswer((realInvocation) => Future.value());
    when(referenceMock.putFile(any))
        .thenAnswer((realInvocation) => uploadTaskMock);
    when(uploadTaskMock.then(any))
        .thenAnswer((realInvocation) => Future.value(tDownloadUrl));
    when(collectionReferenceMock.doc(any))
        .thenAnswer((realInvocation) => documentReferenceMock);
  }

  void setUpFirebaseAuth() {
    when(firebaseAuthMock.currentUser).thenAnswer((realInvocation) => userMock);
  }

  void setUpFirebaseFirestore() {
    when(firebaseFirestoreMock.doc(any))
        .thenAnswer((realInvocation) => documentReferenceMock);

    when(firebaseFirestoreMock.collection(any))
        .thenAnswer((realInvocation) => collectionReferenceMock);
  }

  void setUpFirebaseStorage() {
    when(firebaseStorageMock.ref())
        .thenAnswer((realInvocation) => referenceMock);
  }

  void setUpSuccessfullAuth(String tUserEmal, String tUserPassword) {
    when(firebaseAuthMock.signInWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword))
        .thenAnswer(((realInvocation) async => userCredentialsMock));
    when(firebaseAuthMock.createUserWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword))
        .thenAnswer(((realInvocation) async => userCredentialsMock));
  }

  void setUpFailedAuth(String tUserEmal, String tUserPassword) {
    when(firebaseAuthMock.signInWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword))
        .thenThrow(FirebaseAuthException(code: "exception"));
    when(firebaseAuthMock.createUserWithEmailAndPassword(
            email: tUserEmal, password: tUserPassword))
        .thenThrow(FirebaseAuthException(code: "exception"));
  }
}
