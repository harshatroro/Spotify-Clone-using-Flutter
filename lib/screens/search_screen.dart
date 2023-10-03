// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/providers.dart';
import 'package:spotify_clone/screens/result_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:spotify_clone/widgets/no_internet_dialog.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  Future<bool> connected() async {
    final connection = await Connectivity().checkConnectivity();
    if(connection == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  void checkConnection(BuildContext context) async {
    bool connection = await connected();
    if(connection) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ResultScreen(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => const NoInternetDialog(),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: textEditingController,
                  onSubmitted: (String value) {
                    checkConnection(context);
                  },
                  onChanged: (value) {
                    ref.read(queryProvider.notifier).state = value;
                  },
                  decoration: const InputDecoration(
                    labelText: "Search Songs, Artists & Albums...",
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                OutlinedButton(
                  onPressed: () {
                    checkConnection(context);
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const ColorScheme.light().primary,
                    foregroundColor: const ColorScheme.light().onPrimary,
                  ),
                  child: const Text("Search"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
