import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mockito/mockito.dart';

class UserMock extends Mock implements User {
  // static final UserMock userMock = UserMock();
}

class ReferenceMock extends Mock implements Reference {
  // static final ReferenceMock referenceMock = ReferenceMock();
}

class UploadTaskMock extends Mock implements UploadTask {
  // UploadTaskMock uploadTaskMock = UploadTaskMock();
}

class DocumentReferenceMock extends Mock implements DocumentReference {
  // DocumentReferenceMock documentReferenceMock = DocumentReferenceMock();
}

class CollectionReferenceMock extends Mock implements CollectionReference {
  // CollectionReferenceMock collectionReferenceMock = CollectionReferenceMock();
}

class UserCredentialsMock extends Mock implements UserCredential {
  // UserCredentialsMock userCredentialsMock = UserCredentialsMock();
}

class QuerySnapshotMock extends Mock implements QuerySnapshot {
  // UserCredentialsMock userCredentialsMock = UserCredentialsMock();
}

class DocumentSnapshotMock extends Mock implements DocumentSnapshot {
  // UserCredentialsMock userCredentialsMock = UserCredentialsMock();
}
