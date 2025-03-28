import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_guide.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_guide_detail.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_guide_header.dart';
import 'package:loadin_guide_scann/src/core/common/entities/material.dart';
import 'package:loadin_guide_scann/src/core/common/entities/mining_owner.dart';
import 'package:loadin_guide_scann/src/core/common/entities/owner_driver_vehicle.dart';
import 'package:loadin_guide_scann/src/core/common/widgets/loader.dart';
import 'package:loadin_guide_scann/src/core/theme/app_pallete.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/variables_constat.dart';
import 'package:loadin_guide_scann/src/features/guide/presentation/pages/guide_error_page.dart';
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
        code: code ?? '',
        loadingGuide: LoadingGuide(
          guideHeader: LoadingGuideHeader(
            id: 1,
            guideNumber: 'TLC-001',
            createdAt: '2023-10-01',
            status: 'active',
            remarks: 'Test remarks',
            vehicleId: 1,
            driverId: 1,
            driver: OwnerDriverVehicle(
                id: 1,
                name: 'Juan Juancito',
                lastname: 'Polo Polencio',
                numberIdentification: '1105617172',
                direction: 'Av. 10 de agosto',
                phone1: '0987654321',
                phone2: '0987654321'),
            ownerId: 1,
            owner: OwnerDriverVehicle(
              id: 1,
              name: 'Juan Juancito',
              lastname: 'Polo Polencio',
              numberIdentification: '1105617172',
              direction: 'Av. 10 de agosto',
              phone1: '0987654321',
              phone2: '0987654321',
            ),
            miningOwnerId: 1,
            miningOwner: MiningOwner(
              id: 1,
              name: 'Juan Juancito',
              lastname: 'Polo Polencio',
              numberIdentification: '1105617172',
              direction: 'Av. 10 de agosto',
              email: '1@gmail.com',
            ),
          ),
          guideDetails: [
            LoadingGuideDetail(
              id: 1,
              quantity: 15,
              unit: 'm^3',
              miningOwnerMineMaterialId: 1,
              status: 'active',
              materialId: 1,
              mineId: 1,
              material: MaterialMine(
                  id: 1,
                  name: 'Piedra picapiedra pedrosa',
                  status: 'Description of material 1',
                  quantity: 50000.0),
            ),
            LoadingGuideDetail(
              id: 1,
              quantity: 5,
              unit: 'm^3',
              miningOwnerMineMaterialId: 1,
              status: 'active',
              materialId: 1,
              mineId: 1,
              material: MaterialMine(
                  id: 1,
                  name: 'Piedra picapiedra pedrosa',
                  status: 'Description of material 1',
                  quantity: 50000.0),
            ),
            // LoadingGuideDetail(
            //   id: 1,
            //   quantity: 5,
            //   unit: 'm^3',
            //   miningOwnerMineMaterialId: 1,
            //   status: 'active',
            //   materialId: 1,
            //   mineId: 1,
            //   material: MaterialMine(
            //       id: 1,
            //       name: 'Piedra picapiedra pedrosa',
            //       status: 'Description of material 1',
            //       quantity: 50000.0),
            // ),
          ],
        )));
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
                          SelectGuidePage(loadingGuide: state.loadingGuide)))
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
