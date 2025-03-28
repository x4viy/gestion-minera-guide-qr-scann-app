import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadin_guide_scann/src/core/theme/app_pallete.dart';

class GuideErrorPage extends StatelessWidget {
  static route({required List<String> errorList}) => MaterialPageRoute(
        builder: (context) => GuideErrorPage(errorList: errorList),
      );
  const GuideErrorPage({super.key, required this.errorList});
  final List<String> errorList;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
        Navigator.pop(context, true);
      },
      child: Scaffold(
        backgroundColor: AppPallete.backgroundColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.05,
                  right: screenWidth * 0.05,
                  top: screenHeight * 0.1),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 62.0, horizontal: 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: const Icon(
                          CupertinoIcons.xmark_circle,
                          color: AppPallete.redWaring,
                          size: 90,
                          weight: 80,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Guía no válida',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: errorList.map((error) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text('‣ '),
                                ),
                                Flexible(
                                  child: Text(
                                    error,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
