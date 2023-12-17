import '../models/crypto_model.dart';

abstract class AbstractCoinRepository {
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoin> getCoinDetails(String code);
}
