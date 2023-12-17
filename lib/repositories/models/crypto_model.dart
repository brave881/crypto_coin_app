import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  const CryptoCoin(
      {required this.coinEuro,
      required this.name,
      required this.coinInUSD,
      required this.imageUrl});

  final String name;
  final double coinInUSD;
  final String imageUrl;
  final double coinEuro;

  @override
  List<Object?> get props => [name, coinInUSD, imageUrl, coinEuro];
}
