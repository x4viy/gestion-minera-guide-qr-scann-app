part of 'qr_scann_bloc.dart';

abstract class QRState extends Equatable {
  const QRState();

  @override
  List<Object?> get props => [];
}

class QRInitial extends QRState {}

class QRLoading extends QRState {}

class QRLoaded extends QRState {
  final String response;
  final LoadingSetServer loadingSetServer;

  const QRLoaded(this.response, this.loadingSetServer);

  @override
  List<Object?> get props => [response];

  @override
  String toString() => 'QRLoaded { response: $response }';
}

class QRError extends QRState {
  final String message;
  const QRError(this.message);

  @override
  List<Object?> get props => [message];
}
