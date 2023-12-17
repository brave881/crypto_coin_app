import 'package:flutter/material.dart';
import 'package:learn_flutter/repositories/models/crypto_model.dart';
import 'package:money_formatter/money_formatter.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({super.key, required this.coin});

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        coin.name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        MoneyFormatter(amount: coin.coinInUSD).output.compactSymbolOnRight,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      leading: Image.network(
        coin.imageUrl,
        width: 40,
        height: 40,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      autofocus: true,
      focusColor: Colors.blue,
      hoverColor: Colors.blue,
      onTap: () {
        Navigator.of(context).pushNamed('/coin', arguments: coin);
      },
    );
  }
}
