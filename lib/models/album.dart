import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/track.dart';

class Album {
  final List<Artist> artists;
  final List<String> genres;
  final String id;
  final String imageUrl;
  final String label;
  final String name;
  final int popularity;
  final String releaseDate;
  final int totalTracks;
  final List<Track> tracks;
  final String type;

  Album({
    required this.artists,
    required this.genres,
    required this.id,
    required this.imageUrl,
    required this.label,
    required this.name,
    required this.popularity,
    required this.releaseDate,
    required this.totalTracks,
    required this.tracks,
    required this.type,
  });

  Album.fromJson(Map<String, dynamic> json)
    : artists = List<Artist>.from(
        json["artists"].map(
          (x) => Artist.fromJson(x)
        )
      ),
      genres = List<String>.from(json["genres"]),
      id = json["id"],
      imageUrl = json["images"][0]["url"],
      label = json["label"],
      name = json["name"],
      popularity = json["popularity"],
      releaseDate = json["release_date"],
      totalTracks = json["total_tracks"],
      tracks = List<Track>.from(
        json["tracks"]["items"].map(
          (x) => Track.fromJson(x)
        )
      ),
      type = json["type"];
}
