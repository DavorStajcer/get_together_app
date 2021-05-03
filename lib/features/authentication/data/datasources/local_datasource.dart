import '../models/user_data_model.dart';
import '../../domain/entities/user_data.dart';

abstract class LocalDatasource {
  Future<UserData> getCurrentUserData();
  Future<void> storeCurrentUserData(UserDataModel userDataModel);
}
