import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:learn_flutter/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:learn_flutter/features/crypto_list/bloc/crypto_list_event.dart';
import 'package:learn_flutter/features/crypto_list/bloc/crypto_list_state.dart';
import 'package:learn_flutter/features/crypto_list/widgets/crypto_tile.dart';
import 'package:learn_flutter/repositories/crypto_coin_list/abstaract_coin_repository.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(GetIt.I<AbstractCoinRepository>());

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Crypto list",
          textAlign: TextAlign.center,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if (state is CryptoListSuccess) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    final crypto = state.list[index];
                    return CryptoCoinTile(
                      coin: crypto,
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.list.length);
            }

            if (state is CryptoListError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Something went wrong!",
                      style: theme.textTheme.titleLarge,
                    ),
                    Text(
                      "keyinroq yana try qib ko'r ishlab qoladi!",
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          _cryptoListBloc.add(LoadCryptoList());
                        },
                        child: const Text("Try again"))
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
