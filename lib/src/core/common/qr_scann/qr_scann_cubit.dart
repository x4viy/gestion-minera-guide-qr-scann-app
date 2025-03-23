import 'package:flutter_bloc/flutter_bloc.dart';

part 'qr_scann_state.dart';

class QRScannCubit extends Cubit<QRState> {
  QRScannCubit() : super(QRInitial());

  void scanQRCode(String? messagge) async {
    if (messagge == null) {
      emit(QRError('Error al escanear el código QR'));
    } else {
      emit(QRLoaded(messagge));
    }
  }
}
