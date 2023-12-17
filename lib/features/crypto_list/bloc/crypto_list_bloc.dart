import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:learn_flutter/features/crypto_list/bloc/crypto_list_event.dart';
import 'package:learn_flutter/features/crypto_list/bloc/crypto_list_state.dart';
import 'package:learn_flutter/repositories/crypto_coin_list/abstaract_coin_repository.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this.repository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        emit(CryptoListLoading());
        final result = await repository.getCoinsList();
        // throw Exception("Something happened");
        emit(CryptoListSuccess(list: result));
      } catch (e, st) {
        emit(CryptoListError(error: e));
        GetIt.I<Talker>().handle(e, st, '');
      } finally {
        event.completer?.complete();
      }
    });
  }
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error,stackTrace);
  }

  final AbstractCoinRepository repository;
}
