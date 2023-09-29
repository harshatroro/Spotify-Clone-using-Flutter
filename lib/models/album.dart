import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/track.dart';

class Album {
  final List<Artist> artists;
  final String id;
  final String imageUrl;
  final String name;
  final String releaseDate;
  final int totalTracks;
  final List<Track>? tracks;
  final String type;

  Album({
    required this.artists,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.releaseDate,
    required this.totalTracks,
    required this.tracks,
    required this.type,
  });

  Album.fromJson(Map<String, dynamic> json)
    : artists = List<Artist>.from(json["artists"]?.map((x) => Artist.fromJson(x))),
      id = json["id"],
      imageUrl = json["images"][0]["url"],
      name = json["name"],
      releaseDate = json["release_date"],
      totalTracks = json["total_tracks"],
      tracks = json["tracks"]?["items"] != null ? List<Track>.from(json["tracks"]["items"].map((x) => Track.fromJson(x))) : null,
      type = "Album";

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
