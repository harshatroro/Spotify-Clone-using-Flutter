import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/services/spotify_service.dart';

class Repository {
  final SpotifyService spotifyService;

  Repository({
    required this.spotifyService,
  });

  Future<Map<String, dynamic>> search(String query) async {
    Map<String, dynamic> results = <String, dynamic>{
      "response": {
        "albums": List<Album>.empty(growable: true),
        "artists": List<Artist>.empty(growable: true),
        "tracks": List<Track>.empty(growable: true),
      },
      "error": null,
    };
    final response = await spotifyService.search(query);
    if (response["response"] != null) {
      if (response["response"]["albums"] != null) {
        results["response"].update("albums", (value) => createAlbumsFromJsonData(response["response"]["albums"]["items"]));
      }
      if (response["response"]["tracks"] != null) {
        results["response"].update("tracks", (value) => createTracksFromJsonData(response["response"]["tracks"]["items"]));
      }
      if (response["response"]["artists"] != null) {
        results["response"].update("artists", (value) => createArtistsFromJsonData(response["response"]["artists"]["items"]));
      }
    } else {
      results["error"] = response["error"];
    }
    return results;
  }

  List<Artist> createArtistsFromJsonData(items) {
    List<Artist> results = List<Artist>.empty(growable: true);
    if(items != null){
      for (var item in items) {
        results.add(Artist.fromJson(item));
      }
    }
    return results;
  }

  List<Album> createAlbumsFromJsonData(items) {
    List<Album> results = List<Album>.empty(growable: true);
    if(items != null){
      for (var item in items) {
        results.add(Album.fromJson(item));
      }
    }
    return results;
  }

  List<Track> createTracksFromJsonData(items) {
    List<Track> results = List<Track>.empty(growable: true);
    if(items != null){
      for (var item in items) {
        results.add(Track.fromJson(item));
      }
    }
    return results;
  }

  Future<Map<String, dynamic>> artistDetails(String id) async {
    Map<String, dynamic> results = <String, dynamic>{
      "artist": null,
      "albums": null,
      "artists": null,
      "tracks": null,
      "error": null,
    };
    final artistResponse = await spotifyService.fetchData("artists", id, null);
    if (artistResponse["response"] != null) {
      results["artist"] = Artist.fromJson(artistResponse["response"]);
      final artistAlbumsResponse =
          await spotifyService.fetchData("artists", id, "albums");
      final artistArtistsResponse =
          await spotifyService.fetchData("artists", id, "related-artists");
      final artistTracksResponse =
          await spotifyService.fetchData("artists", id, "top-tracks");
      if (artistAlbumsResponse["response"] != null) {
        results["albums"] = createAlbumsFromJsonData(artistAlbumsResponse["response"]["items"]);
      } else {
        results["error"] =
            "${results["error"] ?? ""} ${artistAlbumsResponse["error"]}";
      }
      if (artistArtistsResponse["response"] != null) {
        results["artists"] = createArtistsFromJsonData(artistArtistsResponse["response"]["items"]);
      } else {
        results["error"] =
            "${results["error"] ?? ""} ${artistArtistsResponse["error"]}";
      }
      if (artistTracksResponse["response"] != null) {
        results["tracks"] = createTracksFromJsonData(artistTracksResponse["response"]["items"]);
      } else {
        results["error"] =
            "${results["error"] ?? ""} ${artistTracksResponse["error"]}";
      }
    } else {
      results["error"] = artistResponse["error"];
    }
    return results;
  }

  Future<Map<String, dynamic>> albumDetails(String id) async {
    Map<String, dynamic> results = <String, dynamic>{
      "album": null,
      "artists": null,
      "tracks": null,
      "error": null,
    };
    final albumResponse = await spotifyService.fetchData("albums", id, null);
    if (albumResponse["response"] != null) {
      results["album"] = Album.fromJson(albumResponse["response"]);
      results["tracks"] = createTracksFromJsonData(albumResponse["response"]["tracks"]["items"]);
      results["artists"] = List<Artist>.empty(growable: true);
      for (Map<String, dynamic> artist in albumResponse["response"]["artists"]["items"]) {
        final response = await spotifyService.fetchData("artists", artist["id"], null);
        if (response["response"] != null) {
          results["artists"].add(Artist.fromJson(response["response"]));
        } else {
          results["error"] = "${results["error"] ?? ""} ${response["error"]}";
        }
      }
    } else {
      results["error"] = albumResponse["error"];
    }
    return results;
  }

  Future<Map<String, dynamic>> trackDetails(String id) async {
    Map<String, dynamic> results = <String, dynamic>{
      "track": null,
      "album": null,
      "artists": null,
      "error": null,
    };
    final trackResponse = await spotifyService.fetchData("tracks", id, null);
    if (trackResponse["response"] != null) {
      results["track"] = Track.fromJson(trackResponse["response"]);
      results["artists"] = List<Artist>.empty(growable: true);
      for (Map<String, dynamic> artist in trackResponse["response"]["artists"]) {
        results["artists"].add(Artist.fromJson(artist));
      }
      results["album"] = Album.fromJson(trackResponse["response"]["album"]);
    } else {
      results["error"] = trackResponse["error"];
    }
    return results;
  }
}
