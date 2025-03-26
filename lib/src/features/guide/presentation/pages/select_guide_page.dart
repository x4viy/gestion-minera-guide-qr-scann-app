import 'package:flutter/material.dart';

class SelectGuidePage extends StatelessWidget {
  static route({required String code}) => MaterialPageRoute(
        builder: (context) => SelectGuidePage(code: code),
      );
  const SelectGuidePage({super.key, required this.code});

  final String code;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
        Navigator.pop(context, true);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Select Guide')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Select Guide Page code: $code'),
              ElevatedButton(
                onPressed: () {
                  // Return true when popping the page
                  // for the scanner to start again.
                  Navigator.pop(context, true);
                },
                child: const Text('Cerrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
