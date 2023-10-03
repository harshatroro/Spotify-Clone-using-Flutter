import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/parent.dart';
import 'package:spotify_clone/providers.dart';

class Track implements Parent {
  Album? album;
  List<Artist> artists;
  int durationMs;
  @override
  String id;
  @override
  String imageUrl;
  @override
  String name;
  @override
  String type;
  @override
  final FutureProviderFamily<Map<String, dynamic>, String> provider = trackDetailsProvider;
  @override
  final String description;

  Track({
    required this.album,
    required this.artists,
    required this.durationMs,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.description,
  });

  Track.fromJson(Map<String, dynamic> json)
  : album = json.containsKey("album") ? Album.fromJson(json["album"]) : null,
    artists = List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    durationMs = json["duration_ms"],
    id = json["id"],
    imageUrl = json.containsKey("album") ? json["album"]["images"][0]["url"] : "",
    name = json.containsKey("name") ? json["name"] : "",
    type = "Track",
    description = "${json["artists"][0]["name"]}";

  Map<String, dynamic> toJson() => {
    "album": album,
    "artists": artists,
    "duration_ms": durationMs,
    "id": id,
    "image_url": imageUrl,
    "name": name,
    "type": type,
  };
}