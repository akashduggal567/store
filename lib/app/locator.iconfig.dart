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
import 'package:store/services/local_storage_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<ApiService>(() => ApiService());
  g.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
  g.registerLazySingleton<CartService>(() => CartService());
  g.registerLazySingleton<CounterService>(() => CounterService());
  g.registerLazySingleton<CustomDialogService>(() => CustomDialogService());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<LocalStorageService>(() => LocalStorageService());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
}
