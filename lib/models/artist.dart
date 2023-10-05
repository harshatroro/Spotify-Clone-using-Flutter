import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/models/parent.dart';
import 'package:spotify_clone/providers.dart';

class Artist implements Parent {
  @override
  final String id;
  @override
  final String type;
  @override
  final String? imageUrl;
  @override
  final String name;
  @override
  final FutureProviderFamily<Map<String, dynamic>, String> provider = artistDetailsProvider;
  @override
  final String description;

  Artist({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.description,
  });

  Artist.fromJson(Map<String, dynamic> json)
    : id = json["id"],
      imageUrl = json.containsKey("images") ? json["images"][0]["url"] : "https://placehold.co/640x640?text=Hello\nWorld",
      name = json["name"] ?? "",
      type = "Artist",
      description = "Artist";

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_url": imageUrl,
    "name": name,
    "type": type,
  };
}