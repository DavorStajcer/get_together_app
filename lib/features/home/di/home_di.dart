import 'package:get_together_app/features/authentication/di/authentication_di.dart';
import '../presentation/bloc/nav_bar_cubit/nav_bar_cubit.dart';
import '../presentation/bloc/nav_bar_style_cubit/nav_bar_style_cubit.dart';

void initHomeDi() {
  getIt.registerFactory(() => NavBarCubit());
  getIt.registerFactory(() => NavBarStyleCubit());
}
