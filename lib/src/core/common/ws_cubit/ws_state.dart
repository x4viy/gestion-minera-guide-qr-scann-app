import 'package:loadin_guide_scann/src/core/common/entities/loading_set.dart';

sealed class WebSocketState {}

final class WebSocketInitial extends WebSocketState {}

final class WebSocketConnecting extends WebSocketState {}

final class WebSocketConnected extends WebSocketState {
  final dynamic data;
  WebSocketConnected(this.data);
}

final class WebSocketLoadingGuideMsg extends WebSocketState {
  final LoadingSetServer loadingGuideSrv;
  WebSocketLoadingGuideMsg(this.loadingGuideSrv);
}

final class WebSocketErrorMsg extends WebSocketState {
  final String errors;
  WebSocketErrorMsg(this.errors);
}

final class WebSocketDisconnected extends WebSocketState {}

final class WebSocketError extends WebSocketState {
  final String message;
  WebSocketError(this.message);
}
