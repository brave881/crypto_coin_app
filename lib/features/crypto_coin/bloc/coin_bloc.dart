import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:learn_flutter/repositories/crypto_coin_list/abstaract_coin_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../repositories/models/crypto_model.dart';

part 'coin_event.dart';

part 'coin_state.dart';

class CoinBloc extends Bloc<CoinEvent, CoinState> {
  CoinBloc(this.repository) : super(CoinState()) {
    on<LoadCrypto>(_load);
  }

  final AbstractCoinRepository repository;

  Future<void> _load(LoadCrypto event, Emitter<CoinState> state) async {
    try {
      if (state is! CoinSuccess) {
        emit(CoinLoading());
      }
      final result = await repository.getCoinDetails(event.currencyCode);
      emit(CoinSuccess(coin: result));
    } catch (e) {
      emit(CoinError(e: e));
      GetIt.I<Talker>().error(e);
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
