import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/artist.dart';

class Track {
  Album album;
  List<Artist> artists;
  int durationMs;
  String id;
  String imageUrl;
  String name;
  String type;

  Track({
    required this.album,
    required this.artists,
    required this.durationMs,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.type,
  });

  Track.fromJson(Map<String, dynamic> json)
  : album = Album.fromJson(json["album"]),
    artists = List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    durationMs = json["duration_ms"],
    id = json["id"],
    imageUrl = json["album"]["images"][0]["url"],
    name = json["name"],
    type = "Track";

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