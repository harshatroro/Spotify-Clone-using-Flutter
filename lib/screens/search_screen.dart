import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/providers.dart';
import 'package:spotify_clone/screens/result_screen.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResultScreen(),
                      ),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResultScreen(),
                      ),
                    );
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
