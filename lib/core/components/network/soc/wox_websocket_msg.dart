import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:web_socket_channel/web_socket_channel.dart';

class WoxWebsocketMsgUtil {
  WoxWebsocketMsgUtil._privateConstructor();

  static final WoxWebsocketMsgUtil _instance =
      WoxWebsocketMsgUtil._privateConstructor();

  static WoxWebsocketMsgUtil get instance => _instance;

  WebSocketChannel? _channel;

  late Uri uri;

  late Function onMessageReceived;

  int connectionAttempts = 1;

  final Map<String, Completer> _completers = {};

  void _connect() {
    _channel?.sink.close();
    _channel = null;

    _channel = WebSocketChannel.connect(uri);
    _channel!.stream.listen(
      (event) {
        // var msg = WoxWebsocketMsg.fromJson(jsonDecode(event));
        // if (msg.success == false) {
        //   log("Received error message: ${msg.toJson()}");
        //   return;
        // }

        // if (_completers.containsKey(msg.id)) {
        //   _completers[msg.id]!.complete(msg);
        //   _completers.remove(msg.id);
        //   return;
        // }

        onMessageReceived(event);
      },
      onDone: () {
        _reconnect();
      },
    );
  }

  void _reconnect() {
    Future.delayed(
        Duration(
            milliseconds:
                200 * (connectionAttempts > 5 ? 5 : connectionAttempts)), () {
      log("Attempting to reconnect to WebSocket... $connectionAttempts");
      connectionAttempts++;
      _connect();
    });
  }

  // before calling other methods, make sure to call initialize() first
  Future<void> initialize(Uri uri,
      {required Function onMessageReceived}) async {
    this.uri = uri;
    this.onMessageReceived = onMessageReceived;
    _connect();
  }

  // send message to websocket server
  Future<dynamic> sendMessage(WoxWebsocketMsg msg) async {
    // if query message, send it directly, no need to wait for response
    // because query result may return multiple times
    if (msg.method == WoxMsgMethodEnum.WOX_MSG_METHOD_QUERY.code) {
      _channel?.sink.add(jsonEncode(msg));
      return;
    }

    Completer completer = Completer();
    _completers[msg.id] = completer;
    _channel?.sink.add(jsonEncode(msg));
    var responseMsg = await completer.future as WoxWebsocketMsg;
    return responseMsg.data;
  }
}

class WoxWebsocketMsg {
  late String id;
  late String method;
  late WoxMsgType type;
  late dynamic data;
  late bool? success;

  WoxWebsocketMsg(
      {required this.id,
      required this.method,
      required this.type,
      this.success = true,
      this.data});

  WoxWebsocketMsg.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    method = json['Method'];
    type = json['Type'];
    data = json['Data'];
    success = json['Success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> finalData = <String, dynamic>{};
    finalData['Id'] = id;
    finalData['Method'] = method;
    finalData['Type'] = type;
    finalData['Success'] = success;
    finalData['Data'] = data;
    return finalData;
  }
}

typedef WoxMsgType = String;

enum WoxMsgTypeEnum {
  WOX_MSG_TYPE_REQUEST("WebsocketMsgTypeRequest", "Request"),
  WOX_MSG_TYPE_RESPONSE("WebsocketMsgTypeResponse", "Response");

  final String code;
  final String value;

  const WoxMsgTypeEnum(this.code, this.value);

  static String getValue(String code) => WoxMsgTypeEnum.values
      .firstWhere((activity) => activity.code == code)
      .value;
}

typedef WoxMsgMethod = String;

enum WoxMsgMethodEnum {
  WOX_MSG_METHOD_PING("Ping", "Ping"),
  WOX_MSG_METHOD_QUERY("Query", "Query"),
  WOX_MSG_METHOD_ACTION("Action", "Action"),
  WOX_MSG_METHOD_REFRESH("Refresh", "Refresh"),
  WOX_MSG_METHOD_REGISTER_MAIN_HOTKEY(
      "RegisterMainHotkey", "Register Main Hotkey"),
  WOX_MSG_METHOD_VISIBILITY_CHANGED("VisibilityChanged", "Visibility changed"),
  WOX_MSG_METHOD_LOST_FOCUS("LostFocus", "Lost focus");

  final String code;
  final String value;

  const WoxMsgMethodEnum(this.code, this.value);

  static String getValue(String code) => WoxMsgMethodEnum.values
      .firstWhere((activity) => activity.code == code)
      .value;
}
