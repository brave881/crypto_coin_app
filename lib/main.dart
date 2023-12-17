import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:learn_flutter/repositories/crypto_coin_list/abstaract_coin_repository.dart';
import 'package:learn_flutter/repositories/crypto_coin_list/crypto_coins_list_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'crypto_coins_app.dart';

void main() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug("debug {{{{{{}}}}}}");
  GetIt.I<Talker>().error("error {{{{{{}}}}}}");
  GetIt.I<Talker>().info("iynfo {{{{{{}}}}}}");
  GetIt.I.registerLazySingleton<AbstractCoinRepository>(
    () => CryptoCoinsRepository(
      dio: Dio(),
    ),
  );
  runApp(const MyApp());
}
