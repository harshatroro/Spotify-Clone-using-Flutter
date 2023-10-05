import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String error;
  final StackTrace? stackTrace;

  const CustomErrorWidget({
    super.key,
    required this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    debugPrintStack(stackTrace: stackTrace);
    return Scaffold(
      body: Center(
        child: Text(error),
      ),
    );
  }
}
