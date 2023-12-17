import 'package:equatable/equatable.dart';

import '../../../repositories/models/crypto_model.dart';

abstract class CryptoListState extends Equatable {}

class CryptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoading extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListSuccess extends CryptoListState {
  CryptoListSuccess({required this.list});

  final List<CryptoCoin> list;

  @override
  List<Object?> get props => [list];
}

class CryptoListError extends CryptoListState {
  CryptoListError({this.error});

  final Object? error;

  @override
  List<Object?> get props => [error];
}
