import 'package:bestpay/shared/database_service.dart';
import 'package:bestpay/shared/navigator_service.dart';
import 'package:bestpay/shared/network_service.dart';
import 'package:bestpay/shared/preference_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;
 PreferenceService get preferenceService => locator<PreferenceService>();
 NavigationService get navigationService => locator<NavigationService>();
DatabaseService get dataBaseService => locator<DatabaseService>();
 void setupLocator() {
   locator.registerLazySingleton(() => PreferenceService());
   locator.registerLazySingleton(() => NetworkService());
   locator.registerLazySingleton(() => NavigationService());
   locator.registerLazySingleton(() => DatabaseService());
 }