import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_guide.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_set.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/variables_constat.dart';

part 'qr_scann_event.dart';
part 'qr_scann_state.dart';

class QrScannBloc extends Bloc<QrScannEvent, QRState> {
  QrScannBloc() : super(QRInitial()) {
    on<QrScannEvent>((_, emit) => emit(QRLoading()));
    on<QRScanned>(_onQRScanned); // Removed the transformer.
    on<QRReset>(_onQRReset);
  }

  Future<void> _onQRScanned(QRScanned event, Emitter<QRState> emit) async {
    if (event.code.isEmpty) {
      emit(QRError('Error scanning the QR code is empty'));
    } else {
      logger.i('QR code scanned: ${event.code} TODO: validate the code');
      emit(QRLoaded(event.code, event.loadingSetServer));
    }
  }

  void _onQRReset(QRReset event, Emitter<QRState> emit) {
    // _lastScannedCode = null; // Reset the last scanned code.
    // logger.i('QR scanner reset');
    emit(QRInitial());
  }
}
