import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/variables_constat.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Home Page',
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buttomNavigationBar(context),
    );
  }
}

Widget _buttomNavigationBar(BuildContext context) {
  return CurvedNavigationBar(
    backgroundColor: Colors.black,
    items: <Widget>[
      Icon(
        Icons.settings,
        size: 30,
        color: Colors.black,
      ),
      Icon(
        Icons.home_rounded,
        size: 30,
        color: Colors.black,
      ),
      Icon(
        Icons.qr_code_scanner_rounded,
        size: 30,
        color: Colors.black,
      ),
    ],
    onTap: (index) {
      logger.d(index);
    },
    animationDuration: const Duration(milliseconds: 300),
  );
}
