import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/variables_constat.dart';
import 'package:loadin_guide_scann/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:loadin_guide_scann/src/features/auth/presentation/pages/login_page.dart';
import 'package:loadin_guide_scann/src/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:loadin_guide_scann/src/features/home/presentation/widgets/scaffold_pages.dart';
import 'package:loadin_guide_scann/src/features/qr_scann/presentation/pages/qr_scann_page.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Widget> _pages() {
  return [
    ConfigPage(),
    HomeIdle(),
    MobileScannerSimple(),
  ];
}

class _HomePageState extends State<HomePage> {
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomePageBloc, HomePageState>(
          // TODO: DELETE THIS LISTENER IF NOT USEDJK
          listener: (context, state) {},
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticated) {
              Navigator.pushAndRemoveUntil(
                context,
                LoginPage.route(),
                (route) => false,
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
      ],
      child: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          return Scaffold(
            body: _body(context, state),
            bottomNavigationBar: _buttomNavigationBar(context, state),
          );
        },
      ),
    );
  }
}

Widget _body(BuildContext context, HomePageState state) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _pages().elementAt(state.tabIndex)),
      ],
    ),
  );
}

Widget _buttomNavigationBar(BuildContext context, HomePageState state) {
  return CurvedNavigationBar(
    backgroundColor: Colors.black,
    height: MediaQuery.of(context).size.height * 0.075,
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
      BlocProvider.of<HomePageBloc>(context)
          .add(ChangeTabEvent(tabIndex: index));
    },
    animationDuration: const Duration(milliseconds: 300),
    index: state.tabIndex,
  );
}
