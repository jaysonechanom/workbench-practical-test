import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String message;
  const LoadingWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  message,
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}