import 'dart:convert';
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
      "artists": null,
      "albums": null,
      "tracks": null,
      "error": null,
    };
    final response = await spotifyService.search(query);
    if (response["response"] != null) {
      if (response["artists"] != null) {
        results["artists"] = List<Artist>.empty(growable: true);
        for (String artist in response["response"]["artists"]["items"]) {
          results["artists"].add(Artist.fromJson(jsonDecode(artist)));
        }
      }
      if (response["albums"] != null) {
        results["albums"] = List<Album>.empty(growable: true);
        for (String artist in response["response"]["albums"]["items"]) {
          results["albums"].add(Album.fromJson(jsonDecode(artist)));
        }
      }
      if (response["tracks"] != null) {
        results["tracks"] = List<Track>.empty(growable: true);
        for (String artist in response["response"]["tracks"]["items"]) {
          results["tracks"].add(Track.fromJson(jsonDecode(artist)));
        }
      }
    } else {
      results["error"] = response["error"];
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
        results["albums"] = List<Album>.empty(growable: true);
        for (String album in artistAlbumsResponse["response"]["items"]) {
          results["albums"].add(Album.fromJson(jsonDecode(album)));
        }
      } else {
        results["error"] =
            "${results["error"] ?? ""} ${artistAlbumsResponse["error"]}";
      }
      if (artistArtistsResponse["response"] != null) {
        results["artists"] = List<Artist>.empty(growable: true);
        for (String artist in artistArtistsResponse["response"]["items"]) {
          results["artists"].add(Artist.fromJson(jsonDecode(artist)));
        }
      } else {
        results["error"] =
            "${results["error"] ?? ""} ${artistArtistsResponse["error"]}";
      }
      if (artistTracksResponse["response"] != null) {
        results["tracks"] = List<Track>.empty(growable: true);
        for (String track in artistTracksResponse["response"]["items"]) {
          results["tracks"].add(Track.fromJson(jsonDecode(track)));
        }
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
      results["tracks"] = List<Track>.empty(growable: true);
      for (String track in albumResponse["response"]["tracks"]["items"]) {
        results["tracks"].add(Track.fromJson(jsonDecode(track)));
      }
      results["artists"] = List<Artist>.empty(growable: true);
      for (String artist in albumResponse["response"]["artists"]["items"]) {
        final response = await spotifyService.fetchData("artists",
            albumResponse["response"]["artists"]["items"][artist]["id"], null);
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
      for (String artist in trackResponse["response"]["artists"]) {
        results["artists"].add(Artist.fromJson(jsonDecode(artist)));
      }
      results["album"] = Album.fromJson(trackResponse["response"]["album"]);
    } else {
      results["error"] = trackResponse["error"];
    }
    return results;
  }
}
