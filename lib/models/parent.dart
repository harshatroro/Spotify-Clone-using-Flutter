import 'package:flutter_riverpod/flutter_riverpod.dart';

interface class Parent {
  final String id;
  final String type;
  final String name;
  final String? imageUrl;
  final FutureProviderFamily<Map<String, dynamic>, String> provider;
  final String description;

  Parent({
    required this.id,
    required this.type,
    required this.name,
    required this.provider,
    this.imageUrl,
    required this.description,
  });
}