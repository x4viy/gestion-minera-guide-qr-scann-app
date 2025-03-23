part of 'qr_scann_cubit.dart';

sealed class QRState {}

final class QRInitial extends QRState {}

final class QRLoading extends QRState {}

final class QRLoaded extends QRState {
  final String response;
  QRLoaded(this.response);
}

final class QRError extends QRState {
  final String message;
  QRError(this.message);
}
