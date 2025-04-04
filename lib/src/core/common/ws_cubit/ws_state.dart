sealed class WebSocketState {}

final class WebSocketInitial extends WebSocketState {}

final class WebSocketConnecting extends WebSocketState {}

final class WebSocketConnected extends WebSocketState {
  final dynamic data;
  WebSocketConnected(this.data);
}

final class WebSocketDisconnected extends WebSocketState {}

final class WebSocketError extends WebSocketState {
  final String message;
  WebSocketError(this.message);
}
