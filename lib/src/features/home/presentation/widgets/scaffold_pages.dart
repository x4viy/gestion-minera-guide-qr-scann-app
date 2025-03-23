import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadin_guide_scann/src/core/common/qr_scann/qr_scann_cubit.dart';
import 'package:loadin_guide_scann/src/core/theme/app_pallete.dart';
import 'package:loadin_guide_scann/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:loadin_guide_scann/src/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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

class QRScannerScreen extends StatelessWidget {
  final BuildContext context;
  const QRScannerScreen({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: _QRViewWidget(),
            ),
            const SizedBox(height: 20),
            BlocBuilder<QRScannCubit, QRState>(
              builder: (context, state) {
                if (state is QRInitial) {
                  return const Text('Scan a QR code to start.');
                } else if (state is QRLoading) {
                  return const CircularProgressIndicator();
                } else if (state is QRLoaded) {
                  return Text('QR Code Data: ${state.response}');
                } else if (state is QRError) {
                  return Text('Error: ${state.message}');
                }
                return Container();
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Optionally simulate a QR scan for testing
                // context.read<QRScannCubit>().add(QRScanned('Sample QR Data'));
              },
              child: const Text('Simulate QR Scan'),
            ),
          ],
        ),
      ),
    );
  }
}

class _QRViewWidget extends StatefulWidget {
  @override
  __QRViewWidgetState createState() => __QRViewWidgetState();
}

class __QRViewWidgetState extends State<_QRViewWidget> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Only trigger QRScanned if the Bloc is not in a loading state
      if (context.read<QRScannCubit>().state is! QRLoading) {
        controller.pauseCamera();
        BlocProvider.of<QRScannCubit>(context)
            .scanQRCode(scanData.code.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
    );
  }
}
