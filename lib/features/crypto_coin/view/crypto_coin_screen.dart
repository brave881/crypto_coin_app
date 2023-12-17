import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:learn_flutter/repositories/crypto_coin_list/abstaract_coin_repository.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../../repositories/models/crypto_model.dart';
import '../bloc/coin_bloc.dart';

class CryptoScreen extends StatefulWidget {
  const CryptoScreen({super.key});

  @override
  State<CryptoScreen> createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  CryptoCoin? coin;

  final _coinBloc = CoinBloc(
    GetIt.I<AbstractCoinRepository>(),
  );

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is CryptoCoin, "You must provide string");
    coin = args as CryptoCoin;
    _coinBloc.add(LoadCrypto(currencyCode: coin!.name));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<CoinBloc, CoinState>(
        bloc: _coinBloc,
        builder: (context, state) {
          if (state is CoinSuccess) {
            var cryptoCoin = state.coin;
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Image.network(cryptoCoin.imageUrl),
                  ),
                  const SizedBox(height: 10),
                  buildContainer(cryptoCoin.name),
                  SizedBox(
                    height: 20,
                  ),
                  buildContainer(cryptoCoin.coinInUSD),
                ],
              ),
            );
          } else if (state is CoinLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Placeholder();
        },
      ),
    );
  }

  Container buildContainer(Object cryptoCoin) {
    return Container(
      height: 60,
      width: 300,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(1, 9), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (cryptoCoin is double)
            Text(
              MoneyFormatter(amount: cryptoCoin).output.symbolOnLeft,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            )
          else
            Text(
              (cryptoCoin as String),
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
