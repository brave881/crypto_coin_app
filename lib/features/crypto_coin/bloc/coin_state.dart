part of 'coin_bloc.dart';

 class CoinState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CoinSuccess extends CoinState {
  CoinSuccess({required this.coin});

  @override
  List<Object?> get props => [coin];

  final CryptoCoin coin;
}

class CryptoInitial extends CoinState {
  @override
  List<Object?> get props => throw UnimplementedError('');
}

class CoinLoading extends CoinState {
  @override
  List<Object?> get props => throw UnimplementedError('');
}

class CoinError extends CoinState {
  final Object e;

  CoinError({required this.e});

  @override
  List<Object?> get props => super.props..add(e);
}
