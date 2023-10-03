import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/repository/repository.dart';
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

final repositoryProvider = Provider<Repository>((ref) {
  final spotifyService = ref.read(spotifyServiceProvider);
  return Repository(
    spotifyService: spotifyService,
  );
});

final queryProvider = StateProvider<String>(
    (ref) => "",
);

final idProvider = StateProvider<String>(
    (ref) => "",
);

final searchProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, query) async {
  final repository = ref.read(repositoryProvider);
  return await repository.search(query);
});

final artistDetailsProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, id) async {
  final repository = ref.read(repositoryProvider);
  return await repository.artistDetails(id);
});

final albumDetailsProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, id) async {
  final repository = ref.read(repositoryProvider);
  return await repository.albumDetails(id);
});

final trackDetailsProvider = FutureProvider.family<Map<String, dynamic>, String>((ref, id) async {
  final repository = ref.read(repositoryProvider);
  return await repository.trackDetails(id);
});