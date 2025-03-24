import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadin_guide_scann/src/core/common/qr_scann/qr_scann_cubit.dart';
import 'package:loadin_guide_scann/src/core/theme/app_pallete.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/variables_constat.dart';
import 'package:loadin_guide_scann/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:loadin_guide_scann/src/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:loadin_guide_scann/src/features/home/presentation/widgets/overlay_qr.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

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
  const HomeIdle({super.key});

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
              child: MobileScannerSimple(),
            ),
            const Text(
              'Qr Scanner',
              style: TextStyle(fontSize: 30),
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

// class _QRViewWidget extends StatefulWidget {
//   @override
//   __QRViewWidgetState createState() => __QRViewWidgetState();
// }

// class __QRViewWidgetState extends State<_QRViewWidget>
//     with WidgetsBindingObserver {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   final MobileScannerController qrController = MobileScannerController();
//   StreamSubscription<Object?>? _subscription;

//   @override
//   void initState() {
//     super.initState();
//     // Start listening to lifecycle changes.
//     WidgetsBinding.instance.addObserver(this);

//     // Finally, start the scanner itself.
//     unawaited(qrController.start());
//   }

//   @override
//   Future<void> dispose() async {
//     // Stop listening to lifecycle changes.
//     WidgetsBinding.instance.removeObserver(this);
//     // Stop listening to the barcode events.
//     unawaited(_subscription?.cancel());
//     _subscription = null;
//     // Dispose the widget itself.
//     super.dispose();
//     // Finally, dispose of the controller.
//     await qrController.dispose();
//   }

//   // void _onQRViewCreated(QRViewController controller) {
//   //   this.controller = controller;
//   //   controller.scannedDataStream.listen((scanData) {
//   //     // Only trigger QRScanned if the Bloc is not in a loading state
//   //     if (context.read<QRScannCubit>().state is! QRLoading) {
//   //       controller.pauseCamera();
//   //       BlocProvider.of<QRScannCubit>(context)
//   //           .scanQRCode(scanData.code.toString());
//   //     }
//   //   });
//   // }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     // If the controller is not ready, do not try to start or stop it.
//     // Permission dialogs can trigger lifecycle changes before the controller is ready.
//     if (!qrController.value.hasCameraPermission) {
//       return;
//     }

//     switch (state) {
//       case AppLifecycleState.detached:
//       case AppLifecycleState.hidden:
//       case AppLifecycleState.paused:
//         return;
//       case AppLifecycleState.resumed:
//         unawaited(qrController.start());
//       case AppLifecycleState.inactive:
//         // Stop the scanner when the app is paused.
//         // Also stop the barcode events subscription.
//         unawaited(_subscription?.cancel());
//         _subscription = null;
//         unawaited(qrController.stop());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;

//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//         borderColor: Colors.red,
//         borderRadius: 10,
//         borderLength: 30,
//         borderWidth: 10,
//         cutOutSize: scanArea,
//       ),
//     );
//   }
// }

class MobileScannerSimple extends StatefulWidget {
  const MobileScannerSimple({super.key});

  @override
  State<MobileScannerSimple> createState() => _MobileScannerSimpleState();
}

class _MobileScannerSimpleState extends State<MobileScannerSimple>
    with SingleTickerProviderStateMixin {
  Barcode? _barcode;
  bool _hasNavigated = false;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Configure an animation controller for the indicator animation.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture barcodeCapture) {
    final Barcode? scannedBarcode = barcodeCapture.barcodes.firstOrNull;
    // If no barcode or we've already navigated, ignore.
    if (scannedBarcode == null || _hasNavigated) return;

    setState(() {
      _barcode = scannedBarcode;
    });

    final String? code = scannedBarcode.rawValue;

    // Let the cubit validate the code.
    context.read<QRScannCubit>().scanQRCode(code);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QRScannCubit, QRState>(
      listener: (context, state) {
        if (state is QRLoaded && !_hasNavigated) {
          // Play the indicator animation.
          _animationController.forward();
          // After a brief delay, navigate and prevent further navigation.
          Future.delayed(const Duration(milliseconds: 700), () {
            setState(() {
              _hasNavigated = true;
            });
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => NextPage(scannedData: state.response),
            //   ),
            // );
            logger.i('QRScanned: ${state.response}');
          });
        }
        if (state is QRError) {
          // Show error message via SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Stack(
        children: [
          // MobileScanner
          MobileScanner(
            onDetect: _handleBarcode,
            overlayBuilder: (context, child) {
              return overlayBuilder(context);
            },
          ),
          // Indicator animation overlay check
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: FadeTransition(
                opacity: _animationController,
                child: const Icon(
                  Icons.check_circle,
                  color: AppPallete.greenOk,
                  size: 68,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
