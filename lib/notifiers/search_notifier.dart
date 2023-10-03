import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/repository/repository.dart';

class RepositoryNotifier extends StateNotifier<Repository> {
  RepositoryNotifier(Repository repository) : super(repository);

  Future<Map<String, dynamic>> search(String query) async {
    return await state.search(query);
  }

  Future<Map<String, dynamic>> artistDetails(String id) async {
    return await state.artistDetails(id);
  }

  Future<Map<String, dynamic>> albumDetails(String id) async {
    return await state.albumDetails(id);
  }

  Future<Map<String, dynamic>> trackDetails(String id) async {
    return await state.trackDetails(id);
  }
}