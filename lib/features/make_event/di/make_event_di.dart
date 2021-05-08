import 'package:get_together_app/core/maps/location_service.dart';
import 'package:get_together_app/features/authentication/di/authentication_di.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/event_card_order_cubit/event_card_order_cubit.dart';
import 'package:get_together_app/features/make_event/presentation/blocs/maps_location_cubit/maps_location_cubit.dart';
import 'package:get_together_app/features/make_event/presentation/util/order_modifier.dart';

void initMakeEventDi() {
  getIt.registerSingleton<OrderModifier>(OrderModifierImpl());
  getIt.registerFactory(() => EventCardOrderCubit(getIt()));
  getIt.registerSingleton<LocationService>(LocationServiceImpl(getIt()));
  getIt.registerFactory(() => MapsLocationCubit(locationService: getIt()));
}
