class Artist {
  final int followers;
  final List<String> genres;
  final String id;
  final int popularity;
  final String type;
  final String imageUrl;
  final String name;

  Artist({
    required this.followers,
    required this.genres,
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.popularity,
    required this.type,
  });

  Artist.fromJson(Map<String, dynamic> json)
    : followers = json["followers"]["total"],
      genres = List<String>.from(json["genres"]),
      id = json["id"],
      imageUrl = json["images"][0]["url"],
      name = json["name"],
      popularity = json["popularity"],
      type = json["type"];

  Map<String, dynamic> toJson() => {
    "followers": followers,
    "genres": genres,
    "id": id,
    "image_url": imageUrl,
    "name": name,
    "popularity": popularity,
    "type": type,
  };
}