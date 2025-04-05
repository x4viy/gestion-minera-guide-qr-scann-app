import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_set.dart';
import 'package:loadin_guide_scann/src/core/common/ws_cubit/ws_cubit.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/variables_constat.dart';

part 'qr_scann_event.dart';
part 'qr_scann_state.dart';

class QrScannBloc extends Bloc<QrScannEvent, QRState> {
  final WebSocketCubit _webSocketCubit;

  QrScannBloc({
    required WebSocketCubit webSocketCubit,
  })  : _webSocketCubit = webSocketCubit,
        super(QRInitial()) {
    on<QrScannEvent>((_, emit) => emit(QRLoading()));
    on<QRScanned>(_onQRScanned); // Removed the transformer.
    on<QRReset>(_onQRReset);
  }

  Future<void> _onQRScanned(QRScanned event, Emitter<QRState> emit) async {
    if (event.code.isEmpty) {
      emit(QRError('Codigo QR no válido'));
    } else {
      logger.i('QR code scanned: ${event.code} TODO: validate the code');
      await _webSocketCubit.sendMessage(event.code);
      emit(QRLoading());
    }
  }

  void _onQRReset(QRReset event, Emitter<QRState> emit) {
    // _lastScannedCode = null; // Reset the last scanned code.
    // logger.i('QR scanner reset');
    emit(QRInitial());
  }
}
