import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadin_guide_scann/src/core/theme/app_pallete.dart';
import 'package:loadin_guide_scann/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:loadin_guide_scann/src/features/auth/presentation/widgets/auth_gradient_button.dart';

class ConfigPage extends StatelessWidget {
  final BuildContext context;
  const ConfigPage({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Configuración',
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 30),
        AuthGradientButton(
          buttonText: 'Cerrar Sesión',
          primaryColor: AppPallete.errorColor,
          secondaryColor: AppPallete.gradient2,
          onPressed: () {
            context.read<AuthBloc>().add(
                  AuthLoggedOut(),
                );
          },
        ),
      ],
    );
  }
}

class ScannerQrPage extends StatelessWidget {
  final BuildContext context;
  const ScannerQrPage({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Scanner QR',
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}

class HomeIdle extends StatelessWidget {
  final BuildContext context;
  const HomeIdle({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Inicio',
          style: TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}
