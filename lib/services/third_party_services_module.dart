import 'package:store/services/counter_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

@registerModule
abstract class ThirdPartyServicesModule {

  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
//  @lazySingleton
//  CounterService get counterService;


}