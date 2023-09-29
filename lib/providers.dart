import 'dart:async';

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

final searchProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.search(
    ref.watch(queryProvider.notifier).state,
  );
});

final artistDetailsProvider = Future<Map<String, dynamic>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.artistDetails(
    ref.watch(idProvider.notifier).state,
  );
} as FutureOr<Map<String, dynamic>> Function());

final albumDetailsProvider = Future<Map<String, dynamic>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.albumDetails(
    ref.watch(idProvider.notifier).state,
  );
} as FutureOr<Map<String, dynamic>> Function());

final trackDetailsProvider = Future<Map<String, dynamic>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.trackDetails(
    ref.watch(idProvider.notifier).state,
  );
} as FutureOr<Map<String, dynamic>> Function());