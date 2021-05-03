import 'package:get_it/get_it.dart';
import '../presentation/bloc/nav_bar_cubit/nav_bar_cubit.dart';
import '../presentation/bloc/nav_bar_style_cubit/nav_bar_style_cubit.dart';

GetIt homeGetIt = GetIt.instance;

void initHomeDi() {
  homeGetIt.registerFactory(() => NavBarCubit());
  homeGetIt.registerFactory(() => NavBarStyleCubit());
}
