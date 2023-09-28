const String accessTokenUrl = "https://accounts.spotify.com/api/token";

const String baseUrl = "https://api.spotify.com/v1";

const String searchUrl = "$baseUrl/search";

String buildUrl(String type, String id, String? request) {
  return "$baseUrl/$type/$id/$request";
}