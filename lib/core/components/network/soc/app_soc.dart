import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/clean_architectures/data/datasource/local/preferences.dart';
import 'package:lettutor/clean_architectures/domain/entities/user/user.dart';
import 'package:socket_io_client/socket_io_client.dart';

enum PendingAction { assetDelete, assetUpload, assetHidden }

class PendingChange {
  final String id;
  final PendingAction action;
  final dynamic value;

  const PendingChange(this.id, this.action, this.value);
}

class WebSocState {
  final Socket? socket;
  final User? user;
  final bool isConnected;
  final List<PendingChange> pendingChanges;

  WebSocState({
    this.socket,
    this.user,
    required this.isConnected,
    required this.pendingChanges,
  });

  WebSocState copyWith({
    Socket? socket,
    bool? isConnected,
    List<PendingChange>? pendingChanges,
    User? user,
  }) =>
      WebSocState(
        user: user,
        isConnected: isConnected ?? this.isConnected,
        socket: socket ?? this.socket,
        pendingChanges: pendingChanges ?? this.pendingChanges,
      );
}

@singleton
class AppSoc extends Cubit<WebSocState> {
  AppSoc() : super(WebSocState(isConnected: false, pendingChanges: []));

  static const String sendMessageEvent = "chat:sendMessage";
  static const String returnNewMessage = "chat:returnNewMessage";
  static const String connectionLogin = "connection:login";
  static const String onlineTutor = "connection:login";

  void connect() {
    try {
      if (state.isConnected) return;

      final accessToken = CommonAppSettingPref.getAccessToken();
      if (accessToken.isNotEmpty) {
        Socket socket = io(
          "wss://sandbox.api.lettutor.com",
          OptionBuilder()
              .setPath("/socket.io")
              .setQuery({"EIO": "4", "transport": "websocket"})
              .setExtraHeaders(
                {
                  "Authorization": "Bearer $accessToken",
                  "Host": "sandbox.api.lettutor.com",
                  "connection": "Upgrade",
                  "Origin": "https://sandbox.app.lettutor.com",
                  "Pragma": "no-cache",
                  "Cache-Control": "no-cache",
                  "Upgrade": "websocket",
                  "Sec-WebSocket-Version": "13",
                  "Sec-WebSocket-Extensions":
                      "permessage-deflate; client_max_window_bits",
                  "Accept-Encoding": "gzip, deflate, br",
                  "Accept-Language": "en-US,en;q=0.9"
                },
              )
              .setTransports(['websocket'])
              .enableReconnection()
              .enableForceNew()
              .setReconnectionAttempts(double.infinity)
              .enableForceNewConnection()
              .enableAutoConnect()
              .build(),
        );

        socket.connect();

        socket.onConnect((data) {
          log("✅ [WEBSOCKET] Connection $data");
          emit(WebSocState(
            isConnected: true,
            socket: socket,
            pendingChanges: state.pendingChanges,
          ));
        });

        socket.onConnectError((error) {
          log("⚠️ [WEBSOCKET] Connect $error");
        });

        socket.onConnecting((data) {
          log("🛫 [WEBSOCKET] Connecting $data");
        });

        socket.onDisconnect((data) {
          log("⚠️ [WEBSOCKET] Disconnection");
          emit(WebSocState(
            isConnected: false,
            socket: null,
            pendingChanges: state.pendingChanges,
          ));
        });

        socket.on('error', (errorMessage) {
          log("⚠️ [WEBSOCKET] Error - $errorMessage");
          emit(WebSocState(
            isConnected: false,
            socket: null,
            pendingChanges: state.pendingChanges,
          ));
        });
      }
    } catch (e) {
      log("⚠️ [WEBSOCKET] Catch Websocket Error - ${e.toString()}");
    }
  }

  void registerEventListener(String event, dynamic Function(dynamic) handler) {
    state.socket?.on(event, handler);
  }

  void disconnect() {
    log("⚠️ [WEBSOCKET] Attempting to disconnect from websocket");

    var socket = state.socket?.disconnect();

    if (socket?.disconnected ?? false) {
      socket?.dispose();
      emit(WebSocState(
        isConnected: false,
        socket: null,
        pendingChanges: state.pendingChanges,
      ));
    }
  }
}
