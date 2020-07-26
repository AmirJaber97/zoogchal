import 'package:get_it/get_it.dart';
import 'package:zoog/caches/preferences.dart';
import 'package:zoog/providers/network_provider.dart';
import 'package:zoog/services/firestore_service.dart';
import 'package:zoog/ui/home/home_viewmodel.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NetworkProvider());
  locator.registerLazySingleton(() => Preferences());
  locator.registerLazySingleton(() => HomeViewModel());
  locator.registerLazySingleton(() => FirestoreService());
}
