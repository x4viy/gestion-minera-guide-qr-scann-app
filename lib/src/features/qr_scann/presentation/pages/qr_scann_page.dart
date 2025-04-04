import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_guide.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_set.dart';
import 'package:loadin_guide_scann/src/core/theme/app_pallete.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/variables_constat.dart';
import 'package:loadin_guide_scann/src/features/guide/presentation/pages/select_guide_page.dart';
import 'package:loadin_guide_scann/src/features/home/presentation/widgets/overlay_qr.dart';
import 'package:loadin_guide_scann/src/features/qr_scann/presentation/bloc/qr_scann_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MobileScannerSimple extends StatefulWidget {
  const MobileScannerSimple({super.key});

  @override
  State<MobileScannerSimple> createState() => _MobileScannerSimpleState();
}

class _MobileScannerSimpleState extends State<MobileScannerSimple>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late MobileScannerController _scannerController;

  @override
  void initState() {
    super.initState();
    _scannerController =
        MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
    // Configure an animation controller for the indicator animation.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.reset();
    context.read<QrScannBloc>().add(QRReset());
  }

  @override
  void dispose() {
    _scannerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleBarcode(BarcodeCapture barcodeCapture) {
    final Barcode? scannedBarcode = barcodeCapture.barcodes.firstOrNull;
    // If no barcode, ignore.
    if (scannedBarcode == null) return;

    final String? code = scannedBarcode.rawValue;

    // Let the bloc validate the code and trigger a state update.
    _scannerController.stop();
    context.read<QrScannBloc>().add(QRScanned(
        code: '123',
        loadingSetServer: LoadingSetServer.fromJson({
          "loadingGuide": {
            "guideHeader": {
              "id": 3,
              "guide_number": "14735f29-efc1-461b-8176-4c5bb4ab74b4",
              "status": "10",
              "remarks": "obs adicional",
              "miningowner_id": 1,
              "owner_driver_vehicles_id": 1,
              "vehicle_id": 1,
              "driver_id": 2,
              "owner_id": 1,
              "created_by": 5,
              "updated_by": null,
              "createdAt": "2025-04-03T14:05:25.190Z",
              "updatedAt": "2025-04-03T14:05:25.190Z",
              "VehicleId": {"id": 1},
              "DriverId": {
                "id": 2,
                "name": "juancho",
                "lastname": "conductor_de_jose"
              },
              "OwnerId": {"id": 1, "name": "jose", "lastname": "duenio2"},
              "MiningOwnerId": {
                "id": 1,
                "name": "camilo",
                "lastname": "legal",
                "number_identification": "1234567890",
                "institution_name": "institucion"
              }
            },
            "guideDetails": [
              {
                "id": 3,
                "quantity": 15,
                "unit": "M3",
                "status": "10",
                "remarks": "obs material",
                "material_id": 1,
                "mine_id": 1,
                "loading_guide_header_id": 3,
                "miningowner_mine_material_id": 1,
                "created_by": 5,
                "updated_by": null,
                "createdAt": "2025-04-03T14:05:25.201Z",
                "updatedAt": "2025-04-03T14:05:25.201Z",
                "MiningOwnerMineMaterialId": {"id": 1, "quantity": 500},
                "MineId": {
                  "id": 1,
                  "name": "MIna1",
                  "authorized_date": "2025-03-05"
                },
                "MaterialId": {"id": 1, "name": "Piedra"}
              }
            ]
          },
          "vehicle": {
            "id": 1,
            "card": "ABS-123",
            "rfid_code": "12398012089380",
            "brand": "FORD",
            "color": "Negreo",
            "volume": 15,
            "type": "cisterna",
            "status": "1",
            "created_by": 1,
            "updated_by": null,
            "createdAt": "2025-03-05T21:51:55.614Z",
            "updatedAt": "2025-03-05T21:51:55.614Z"
          }
        })));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrScannBloc, QRState>(
      listener: (context, state) async {
        switch (state) {
          case QRLoaded():
            // context.read<QrScannBloc>().add(QRReset());
            _animationController.reset();
            await Future.wait([
              _scannerController.stop(),
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) =>
                          //  GuideErrorPage(
                          //       errorList: [
                          //         'No se encunetra en la lista de seleecion',
                          //       ],
                          //     ))
                          SelectGuidePage(
                              loadingSetServer: state.loadingSetServer)))
                  .then((result) async {
                if (result == true) {
                  logger.i('Restarting the scanner after popping the page');
                  await _scannerController.start();
                }
              }),
            ]);
            // Navigator.push(
            //     context, SelectGuidePage.route(code: state.response));
            break;
          case QRError():
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            break;
        }
        // if (state is QRLoaded) {
        //   // Play the indicator animation.
        //   // _animationController.forward();
        //   // Check that the widget is still mounted.
        //   if (!mounted) return;
        //   // Navigate to the select guide page.
        //   Navigator.push(context, SelectGuidePage.route());
        //   logger.i('QRScanned: ${state.response}');
        // }
        // if (state is QRError) {
        //   // Show error message via SnackBar.
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text(state.message)),
        //   );
        // }
      },
      child: Stack(
        children: [
          // MobileScanner widget.
          MobileScanner(
            controller: _scannerController,
            onDetect: _handleBarcode,
            overlayBuilder: (context, child) {
              return overlayBuilder(context);
            },
          ),
          // Indicator animation overlay.
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: FadeTransition(
                opacity: _animationController,
                child: const Icon(
                  Icons.check_circle,
                  color: AppPallete.greenOk,
                  size: 96,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
