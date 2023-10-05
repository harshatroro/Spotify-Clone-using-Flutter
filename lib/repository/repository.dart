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
        for(var item in response["response"]["albums"]["items"]) {
          final albumResponse = await spotifyService.fetchData("albums", item["id"], null);
          if (albumResponse["response"] != null) {
            for(var artist in albumResponse["response"]["artists"]) {
              if(!artist.containsKey("images")) {
                artist.putIfAbsent("images", () => [{"url": "https://placehold.co/640x640?text=No+Image", "height": 640, "width": 640}]);
              }
            }
            results["response"]["albums"].add(Album.fromJson(albumResponse["response"]));
          } else {
            results["error"] = "${results["error"] ?? ""} ${albumResponse["error"]}";
          }
        }
      }
      if (response["response"]["tracks"] != null) {
        for(var item in response["response"]["tracks"]["items"]) {
          final trackResponse = await spotifyService.fetchData("tracks", item["id"], null);
          if (trackResponse["response"] != null) {
            for(var artist in trackResponse["response"]["album"]["artists"]) {
              if(!artist.containsKey("images")) {
                artist.putIfAbsent("images", () => [{"url": "https://placehold.co/640x640?text=No+Image", "height": 640, "width": 640}]);
              }
            }
            for(var artist in trackResponse["response"]["artists"]) {
              if(!artist.containsKey("images")) {
                artist.putIfAbsent("images", () => [{"url": "https://placehold.co/640x640?text=No+Image", "height": 640, "width": 640}]);
              }
            }
            results["response"]["tracks"].add(Track.fromJson(trackResponse["response"]));
          } else {
            results["error"] = "${results["error"] ?? ""} ${trackResponse["error"]}";
          }
        }
      }
      if (response["response"]["artists"] != null) {
        for(var item in response["response"]["artists"]["items"]) {
          final artistResponse = await spotifyService.fetchData("artists", item["id"], null);
          if (artistResponse["response"] != null) {
            if(!artistResponse["response"].containsKey("images")) {
              artistResponse.putIfAbsent("images", () => [{"url": "https://placehold.co/640x640?text=No+Image", "height": 640, "width": 640}]);
            }
            results["response"]["artists"].add(Artist.fromJson(artistResponse["response"]));
          } else {
            results["error"] = "${results["error"] ?? ""} ${artistResponse["error"]}";
          }
        }
      }
    } else {
      results.update("error", (value) => response["error"]);
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
      final artistArtistsResponse = await spotifyService.fetchData("artists", id, "related-artists");
      final artistAlbumsResponse = await spotifyService.fetchData("artists", id, "albums");
      final artistTracksResponse = await spotifyService.fetchData("artists", id, "top-tracks");
      if (artistAlbumsResponse["response"] != null) {
        results["albums"] = createAlbumsFromJsonData(artistAlbumsResponse["response"]["items"]);
      } else {
        results["error"] = "${results["error"] ?? ""} ${artistAlbumsResponse["error"]}";
      }
      if (artistArtistsResponse["response"] != null) {
        results["artists"] = createArtistsFromJsonData(artistArtistsResponse["response"]["artists"]);
      } else {
        results["error"] = "${results["error"] ?? ""} ${artistArtistsResponse["error"]}";
      }
      if (artistTracksResponse["response"] != null) {
        results["tracks"] = createTracksFromJsonData(artistTracksResponse["response"]["tracks"]);
      } else {
        results["error"] = "${results["error"] ?? ""} ${artistTracksResponse["error"]}";
      }
    } else {
      results["error"] = artistResponse["error"];
    }
    return results;
  }

  Future<Map<String, dynamic>> albumDetails(String id) async {
    Map<String, dynamic> results = <String, dynamic>{
      "album": null,
      "albums": List<Album>.empty(growable: true),
      "artists": List<Artist>.empty(growable: true),
      "tracks": List<Track>.empty(growable: true),
      "error": null,
    };
    final albumResponse = await spotifyService.fetchData("albums", id, null);
    if (albumResponse["response"] != null) {
      results["album"] = Album.fromJson(albumResponse["response"]);
      results["albums"].add(results["album"]);
      for (Map<String, dynamic> track in albumResponse["response"]["tracks"]["items"]) {
        final response = await spotifyService.fetchData("tracks", track["id"], null);
        if (response["response"] != null) {
          results["tracks"].add(Track.fromJson(response["response"]));
        } else {
          results["error"] = "${results["error"] ?? ""} ${response["error"]}";
        }
      }
      for (Map<String, dynamic> artist in albumResponse["response"]["artists"]) {
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
      "tracks": List<Track>.empty(growable: true),
      "albums": List<Album>.empty(growable: true),
      "artists": List<Artist>.empty(growable: true),
      "error": null,
    };
    final trackResponse = await spotifyService.fetchData("tracks", id, null);
    if (trackResponse["response"] != null) {
      results["track"] = Track.fromJson(trackResponse["response"]);
      results["tracks"].add(results["track"]);
      results["albums"].add(Album.fromJson(trackResponse["response"]["album"]));
      for (Map<String, dynamic> artist in trackResponse["response"]["artists"]) {
        final response = await spotifyService.fetchData("artists", artist["id"], null);
        if (response["response"] != null) {
          results["artists"].add(Artist.fromJson(response["response"]));
        } else {
          results["error"] = "${results["error"] ?? ""} ${response["error"]}";
        }
      }
    } else {
      results["error"] = trackResponse["error"];
    }
    return results;
  }
}
