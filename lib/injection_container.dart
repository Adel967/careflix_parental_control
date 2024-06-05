import 'package:careflix_parental_control/core/app/state/app_state.dart';
import 'package:careflix_parental_control/layers/bloc/connecting/connecting_cubit.dart';
import 'package:careflix_parental_control/layers/bloc/rule/rule_cubit.dart';
import 'package:careflix_parental_control/layers/bloc/search/search_cubit.dart';
import 'package:careflix_parental_control/layers/data/data_provider/connecting_provider.dart';
import 'package:careflix_parental_control/layers/data/data_provider/profile_provider.dart';
import 'package:careflix_parental_control/layers/data/data_provider/rule_provider.dart';
import 'package:careflix_parental_control/layers/data/data_provider/search_provider.dart';
import 'package:careflix_parental_control/layers/data/repository/connection_repository.dart';
import 'package:careflix_parental_control/layers/data/repository/profile_repository.dart';
import 'package:careflix_parental_control/layers/data/repository/rule_repository.dart';
import 'package:careflix_parental_control/layers/data/repository/search_repository.dart';
import 'package:get_it/get_it.dart';

import 'l10n/local_provider.dart';

final sl = GetIt.instance;

void initInjection() {
  //cubit
  sl.registerLazySingleton(() => ConnectingCubit());
  sl.registerLazySingleton(() => RuleCubit());
  sl.registerLazySingleton(() => SearchCubit());

  //Provider
  sl.registerLazySingleton(() => LocaleProvider());
  sl.registerLazySingleton(() => AppState());

  //repos
  sl.registerLazySingleton(() => ConnectingRepository(sl()));
  sl.registerLazySingleton(() => ProfileRepository(sl()));
  sl.registerLazySingleton(() => RuleRepository(sl()));
  sl.registerLazySingleton(() => SearchRepository(sl()));

  //data_provider
  sl.registerLazySingleton(() => ConnectingProvider());
  sl.registerLazySingleton(() => ProfileProvider());
  sl.registerLazySingleton(() => RuleProvider());
  sl.registerLazySingleton(() => SearchProvider());
}
