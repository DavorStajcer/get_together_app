import 'package:get_it/get_it.dart';
import 'package:get_together_app/core/network.dart/network_info.dart';
import 'package:get_together_app/features/authentication/domain/repository/user_repository.dart';
import 'package:get_together_app/features/authentication/domain/usecases/listen_to_auth_state_changes.dart';
import 'package:get_together_app/features/authentication/domain/usecases/log_user_in.dart';
import 'package:get_together_app/features/authentication/domain/usecases/sign_user_in.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/auth_check_bloc/authentication_check_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/auth_mode_cubit/auth_mode_cubit.dart';
import 'package:get_together_app/features/authentication/presentation/bloc/form_bloc/form_bloc.dart';

import '../data/repositories/user_repository_impl.dart';

final getIt = GetIt.instance;

init() {
  print("registered objects");

  //Auth
  getIt.registerFactory<AuthBloc>(
      () => AuthBloc(logUserIn: getIt(), signUserIn: getIt()));
  getIt.registerLazySingleton(() => LogUserIn(getIt()));
  getIt.registerLazySingleton(() => SignUserIn(getIt()));

  //AuthCheck
  getIt.registerFactory<AuthenticationCheckBloc>(() => AuthenticationCheckBloc(
      networkInfo: getIt<NetworkInfo>(),
      listenToAuthStateChanges: getIt<ListenToAuthStateChanges>()));

  getIt.registerLazySingleton<ListenToAuthStateChanges>(
      () => ListenToAuthStateChanges(getIt()));

  //AuthModeCubit
  getIt.registerFactory(() => AuthModeCubit());

  //AuthForm
  getIt.registerFactory(() => FormBloc());

  //Common

  getIt.registerLazySingleton<UserAuthRepository>(
      () => UserAuthRepositoryImpl(networkInfo: getIt()));

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  getIt.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
}
