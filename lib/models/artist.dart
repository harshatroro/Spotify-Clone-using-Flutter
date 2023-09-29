class Artist {
  final String id;
  final String type;
  final String? imageUrl;
  final String name;

  Artist({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.type,
  });

  Artist.fromJson(Map<String, dynamic> json)
    : id = json["id"] ?? "",
      imageUrl = json["images"]?[0]?["url"],
      name = json["name"] ?? "",
      type = "Artist";

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "name": name,
    "type": type,
  };
}