import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/services/spotify_service.dart';

final dioProvider = Provider<Dio>(
  (ref) => Dio(),
);

final spotifyServiceProvider = Provider<SpotifyService>((ref) {
  final dio = ref.read(dioProvider);
  return SpotifyService(
    dio: dio,
  );
});

final queryProvider = StateProvider<String>(
    (ref) => "",
);