import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/models/parent.dart';
import 'package:spotify_clone/providers.dart';
import 'package:spotify_clone/screens/intermediate_screen.dart';

class ResultScreenWidget extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;
  const ResultScreenWidget({super.key, required this.data});

  @override
  ConsumerState<ResultScreenWidget> createState() => _ResultScreenWidgetState();
}

class _ResultScreenWidgetState extends ConsumerState<ResultScreenWidget> {
  String type = "All";
  List<Parent> data = List.empty(growable: true);
  List<Parent> filteredData = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    data.addAll(widget.data["artists"]);
    data.addAll(widget.data["albums"]);
    data.addAll(widget.data["tracks"]);
    filteredData.addAll(data);
  }

  void filterData(String newSelectedType) {
    List<Parent> newFilteredData = List.empty(growable: true);
    if(newSelectedType == "All") {
      newFilteredData = data;
    } else {
      newFilteredData = data.where((element) => element.type == newSelectedType).toList();
    }
    setState(() {
      type = newSelectedType;
      filteredData = newFilteredData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceChip(
                    label: const Text(
                      "All"
                    ),
                    selected: type == "All",
                    onSelected: (bool value) {
                      filterData("All");
                    },
                  ),
                  ChoiceChip(
                    label: const Text(
                      "Albums"
                    ),
                    selected: type == "Album",
                    onSelected: (bool value) {
                      filterData("Album");
                    },
                  ),
                  ChoiceChip(
                    label: const Text(
                      "Artists"
                    ),
                    selected: type == "Artist",
                    onSelected: (bool value) {
                      filterData("Artist");
                    },
                  ),
                  ChoiceChip(
                    label: const Text(
                      "Tracks"
                    ),
                    selected: type == "Track",
                    onSelected: (bool value) {
                      filterData("Track");
                    },
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: filteredData.map((e) => ListTile(
                      title: Text(e.name),
                      subtitle: Text(e.type),
                      leading: Image.network(
                        e.imageUrl ?? "",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      onTap: () {
                        ref.read(idProvider.notifier).state = e.id;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                              IntermediateScreen(
                                object: e,
                            ),
                          ),
                        );
                      },
                    )).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
