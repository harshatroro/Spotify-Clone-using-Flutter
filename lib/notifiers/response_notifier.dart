import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponseNotifier extends StateNotifier<dynamic> {
  ResponseNotifier(dynamic data) : super(data);

  void update(dynamic data) {
    state = data;
  }

  void clear() {
    state = null;
  }

  dynamic get data => state;
}