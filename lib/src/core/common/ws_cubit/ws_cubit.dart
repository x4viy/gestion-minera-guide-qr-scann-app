import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadin_guide_scann/src/core/common/ws_cubit/ws_state.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketCubit extends Cubit<WebSocketState> {
  final String socketUrl;
  WebSocketChannel? _channel;

  WebSocketCubit({required this.socketUrl}) : super(WebSocketInitial());

  void connect() {
    if (_channel != null) return;

    emit(WebSocketConnecting());

    try {
      _channel = WebSocketChannel.connect(Uri.parse(socketUrl));
      _channel!.stream.listen(
        (message) {
          try {
            final decoded = json.decode(message);
            emit(WebSocketConnected(decoded));
          } catch (e) {
            emit(WebSocketError(message));
          }
        },
        onError: (error) {
          _channel = null;
          emit(WebSocketError(error.toString()));
        },
        onDone: () {
          _channel = null;
          emit(WebSocketDisconnected());
        },
      );
    } catch (e) {
      emit(WebSocketError(e.toString()));
    }
  }

  bool get isConnected => _channel != null;

  void sendCode(String code) {
    if (isConnected) {
      _channel!.sink.add(code);
    } else {
      emit(WebSocketError("Socket not connected. Attempting to reconnect."));
      connect();
    }
  }

  @override
  Future<void> close() {
    _channel?.sink.close();
    return super.close();
  }
}
