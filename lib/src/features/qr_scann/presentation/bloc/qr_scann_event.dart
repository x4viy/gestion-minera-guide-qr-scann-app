part of 'qr_scann_bloc.dart';

sealed class QrScannEvent extends Equatable {
  const QrScannEvent();

  @override
  List<Object> get props => [];
}

/// Event triggered when a QR code is scanned.
final class QRScanned extends QrScannEvent {
  final String code;

  const QRScanned({required this.code});

  @override
  List<Object> get props => [code];

  @override
  String toString() => 'QRScanned { code: $code }';
}

/// Event triggered to reset the QR scanner state.
final class QRReset extends QrScannEvent {
  const QRReset();

  @override
  String toString() => 'QRReset';
}
