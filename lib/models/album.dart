import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/parent.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/providers.dart';

class Album implements Parent {
  final List<Artist> artists;
  @override
  final String id;
  @override
  final String imageUrl;
  @override
  final String name;
  final String releaseDate;
  final int totalTracks;
  final List<Track>? tracks;
  @override
  final String type;
  @override
  final FutureProviderFamily<Map<String, dynamic>, String> provider = albumDetailsProvider;
  @override
  final String description;

  Album({
    required this.artists,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.releaseDate,
    required this.totalTracks,
    required this.tracks,
    required this.type,
    required this.description,
  });

  Album.fromJson(Map<String, dynamic> json)
    : artists = List<Artist>.from(json["artists"]?.map((x) => Artist.fromJson(x))),
      id = json["id"],
      imageUrl = json["images"][0]["url"],
      name = json["name"],
      releaseDate = json["release_date"],
      totalTracks = json["total_tracks"],
      tracks = json.containsKey("tracks") ? List<Track>.from(json["tracks"]["items"].map((x) => Track.fromJson(x!))) : null,
      type = "Album",
      description = "${json["release_date"]} • ${json["total_tracks"]} songs";

  Map<String, dynamic> toJson() => {
    "artists": artists,
    "id": id,
    "image_url": imageUrl,
    "name": name,
    "release_date": releaseDate,
    "total_tracks": totalTracks,
    "tracks": tracks,
    "type": type,
  };
}
