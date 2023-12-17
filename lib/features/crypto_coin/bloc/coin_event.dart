part of 'coin_bloc.dart';


abstract class CoinEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCrypto extends CoinEvent {
  final String currencyCode;

  LoadCrypto({required this.currencyCode});

  @override
  List<Object?> get props => super.props..add(currencyCode);
}
