import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/providers.dart';
import 'package:spotify_clone/screens/result_screen_widget.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchProvider);
    return searchResults.when(
      data: (data) {
        if(data["response"] != null){
          return ResultScreenWidget(
            data: data["response"],
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(
                  data["error"]
              ),
            ),
          );
        }
      },
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text(
                error.toString()
            ),
          ),
        );
      },
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
