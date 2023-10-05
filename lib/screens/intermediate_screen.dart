import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/models/parent.dart';
import 'package:spotify_clone/providers.dart';
import 'package:spotify_clone/screens/album_screen.dart';
import 'package:spotify_clone/screens/artist_screen.dart';
import 'package:spotify_clone/screens/track_screen.dart';
import 'package:spotify_clone/widgets/error.dart';
import 'package:spotify_clone/widgets/loading.dart';

class IntermediateScreen extends ConsumerWidget {
  final Parent object;

  const IntermediateScreen({
    super.key,
    required this.object,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.read(idProvider.notifier).state;
    final data = ref.watch(object.provider(id));
    return data.when(
      data: (data) {
        if (data["error"] == null) {
          switch(object.type) {
            case "Artist": return ArtistScreen(data: data);
            case "Album": return AlbumScreen(data: data);
            case "Track": return TrackScreen(data: data);
            default: return const CustomErrorWidget(error: "Error");
          }
        } else {
          return CustomErrorWidget(error: data["error"]);
        }
      },
      error: (error, stackTrace) => CustomErrorWidget(error: error.toString()),
      loading: () => const LoadingWidget(),
    );
  }
}
