import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/providers.dart';
import 'package:spotify_clone/screens/intermediate_screen.dart';

class TrackScreen extends ConsumerWidget {
  final Map<String, dynamic> data;
  const TrackScreen({super.key, required this.data});

  List<Widget> generateTiles(ref, context, items) {
    List<Widget> tiles = [];
    for (var item in items) {
      tiles.add(
        ListTile(
          title: Text(item.name),
          subtitle: Text(item.description),
          leading: Image.network(
            item.imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          onTap: () {
            if(item.id != data["track"].id) {
              ref.read(idProvider.notifier).state = item.id;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IntermediateScreen(object: item),
                ),
              );
            }
          },
        ),
      );
    }
    return tiles;
  }

  List<Widget> generateCards(ref, context, items) {
    List<Widget> cards = [];
    for (var item in items) {
      cards.add(
        Column(
          children: [
            GestureDetector(
              onTap: () {
                if(item.id != data["track"].id) {
                  ref.read(idProvider.notifier).state = item.id;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IntermediateScreen(object: item),
                    ),
                  );
                }
              },
              child: Card(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(item.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.name.length > 20 ? item.name.substring(0, 20) + "..." : item.name,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    }
    return cards;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Image.network(
                      data["track"].imageUrl,
                      width: double.infinity,
                      height: 400,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: 400,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.white,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  data["track"].name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  children: generateTiles(ref, context, data["tracks"]),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Albums",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: generateCards(ref, context, data["albums"]),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Artists",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: generateCards(ref, context, data["artists"]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
