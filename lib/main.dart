import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loadin_guide_scann/di/init_dependencies.dart';
import 'package:loadin_guide_scann/src/core/theme/theme.dart';
import 'package:loadin_guide_scann/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:loadin_guide_scann/src/features/auth/presentation/pages/login_page.dart';
import 'package:loadin_guide_scann/src/features/home/presentation/bloc/home_page_bloc.dart';
import 'package:loadin_guide_scann/src/features/qr_scann/presentation/bloc/qr_scann_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<HomePageBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<QrScannBloc>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scanner Guía de Carga',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
