import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/providers.dart';
import 'package:spotify_clone/screens/result_screen_widget.dart';
import 'package:spotify_clone/widgets/error.dart';
import 'package:spotify_clone/widgets/loading.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(queryProvider);
    final searchResults = ref.watch(searchProvider(query));
    return searchResults.when(
      data: (data) {
        if(data["response"] != null){
          return ResultScreenWidget(
            data: data["response"],
          );
        } else {
          return CustomErrorWidget(error: data["error"]);
        }
      },
      error: (error, stackTrace) => CustomErrorWidget(error: error.toString(), stackTrace: stackTrace),
      loading: () => const LoadingWidget(),
    );
  }
}
