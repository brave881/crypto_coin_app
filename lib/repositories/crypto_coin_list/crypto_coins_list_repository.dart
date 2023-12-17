import 'package:dio/dio.dart';
import 'package:learn_flutter/repositories/crypto_coin_list/abstaract_coin_repository.dart';
import 'package:learn_flutter/repositories/models/crypto_model.dart';

class CryptoCoinsRepository implements AbstractCoinRepository {
  CryptoCoinsRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    final response = await dio.get(
        "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,SOL,AID,CAG,DOV,DOG,FLR,ASTR,USTC,SUSHI&tsyms=USD");
    final data = response.data as Map<String, dynamic>;
    final rawData = data['RAW'] as Map<String, dynamic>;
    final result = rawData.entries.map((e) {
      final usdData = (e.value as Map<String, dynamic>)['USD'];
      final euroData = (e.value as Map<String, dynamic>)['USD'];
      final price = usdData['PRICE'];
      final imageUrl = usdData['IMAGEURL'];
      return CryptoCoin(
          name: e.key,
          coinInUSD: price,
          imageUrl: 'https://www.cryptocompare.com/$imageUrl',
          coinEuro: euroData['PRICE']);
    }).toList();
    return result;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String code) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$code&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final rawData = data['RAW'] as Map<String, dynamic>;
    final coinData = rawData[code] as Map<String, dynamic>;
    final usd = coinData['USD'] as Map<String, dynamic>;
    final priceUsd = usd['PRICE'];
    final priceEur = usd['PRICE'];
    final imageUrl = usd['IMAGEURL'];
    return CryptoCoin(
      coinEuro: priceEur,
      name: code,
      coinInUSD: priceUsd,
      imageUrl: 'https://www.cryptocompare.com/$imageUrl',
    );
  }
}
