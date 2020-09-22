// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:store/services/api.dart';
import 'package:store/services/authentication_service.dart';
import 'package:store/services/cart_service.dart';
import 'package:store/services/counter_service.dart';
import 'package:store/services/custom_dialog_service.dart';
import 'package:store/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:store/ui/views/dashboard/home/home_viewModel.dart';
import 'package:store/services/local_notification_service.dart';
import 'package:store/services/local_storage_service.dart';
import 'package:store/services/location_service.dart';
import 'package:store/services/push_notification_service.dart';
import 'package:store/services/wishlist_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  g.registerLazySingleton<CartService>(() => CartService());
  g.registerLazySingleton<CounterService>(() => CounterService());
  g.registerLazySingleton<CustomDialogService>(() => CustomDialogService());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<LocalNotificationService>(
      () => LocalNotificationService());
  g.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  g.registerLazySingleton<LocationService>(
      () => thirdPartyServicesModule.locationService);
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService());
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackbarService);
  g.registerLazySingleton<WishListService>(() => WishListService());

  //Eager singletons must be registered in the right order
  g.registerSingleton<ApiService>(ApiService());
  g.registerSingleton<HomeViewModel>(HomeViewModel());
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  LocationService get locationService => LocationService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackbarService => SnackbarService();
}
