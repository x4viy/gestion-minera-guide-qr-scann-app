import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadin_guide_scann/src/core/common/entities/loading_set.dart';
import 'package:loadin_guide_scann/src/core/common/ws_cubit/ws_state.dart';
import 'package:loadin_guide_scann/src/core/secrets/app_secrets.dart';
import 'package:loadin_guide_scann/src/core/utils/constants/variables_constat.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketCubit extends Cubit<WebSocketState> {
  final String socketUrl;
  final AppSecretsService appSecretsService;
  WebSocketChannel? _channel;
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  WebSocketCubit({required this.socketUrl, required this.appSecretsService})
      : super(WebSocketInitial());

  Future<void> connect() async {
    if (isConnected) return;

    emit(WebSocketConnecting());

    try {
      final authToken = await appSecretsService.getToken();
      _channel = IOWebSocketChannel.connect(Uri.parse(socketUrl),
          headers: {'Authorization': 'Bearer $authToken'});
      logger.i("ws on : ${Uri.parse(socketUrl)}");

      await _channel!.ready.timeout(const Duration(seconds: timeoutWsConnect));

      _isConnected = true;
      _listenToMessages();
      return;
    } on TimeoutException catch (_) {
      _channel = null;
      emit(WebSocketError('Sin conexión con el servidor: Tiempo agotado'));
    } on WebSocketException catch (e) {
      _channel = null;
      logger.e('❌ WebSocket error: ${e.toString()}');
      emit(WebSocketError('Sin conexión con el servidor'));
    } catch (e) {
      _channel = null;
      logger.e('❌ WebSocket error: ${e.toString()}');
      emit(WebSocketError('Sin conexión con el servidor'));
    }
  }

  void _listenToMessages() {
    if (!_isConnected) {
      emit(WebSocketError('Sin conexión con el servidor'));
    }
    _channel!.stream.listen(
      (message) {
        try {
          final decoded = json.decode(message);
          if (decoded is Map && decoded.containsKey("type")) {
            final type = decoded["type"];
            switch (type) {
              case "loadingGuide":
                final data = LoadingSetServer.fromJson(decoded["data"]);
                emit(WebSocketLoadingGuideMsg(data));
                break;
              case "error":
                final errorInfo = decoded["data"];
                emit(WebSocketError(errorInfo));
                break;
              default:
                emit(WebSocketError("Server error: WSE1"));
            }
          } else {
            emit(WebSocketError("Server error: WSE2"));
          }
        } catch (e) {
          emit(WebSocketError(message));
        }
      },
      onError: (error) {
        _channel = null;
        _isConnected = false;
        emit(WebSocketError(error.toString()));
      },
      onDone: () {
        _channel = null;
        _isConnected = false;
        emit(WebSocketDisconnected());
      },
    );
  }

  Future<void> sendMessage(String message) async {
    if (isConnected) {
      _channel!.sink.add(message);
    } else {
      emit(WebSocketError("Sin conexión con el servidor. Reconectando..."));
      await connect();
    }
  }

  @override
  Future<void> close() {
    _channel?.sink.close();
    _isConnected = false;
    return super.close();
  }
}
