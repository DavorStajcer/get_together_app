import 'package:get_together_app/features/authentication/data/models/user_data_model.dart';
import 'package:get_together_app/features/authentication/domain/entities/user_data.dart';

abstract class LocalDatasource {
  Future<UserData> getCurrentUserData();
  Future<void> storeCurrentUserData(UserDataModel userDataModel);
}
