import 'dart:convert';
import 'dart:io';

mixin SocketEvents {
  void onConnect();
  void onDisconnect();
  void onData(dynamic data);
}

class SocketService {
  static late SocketService instance;

  WebSocket? socket;
  late SocketEvents events;

  bool connected = false;

  factory SocketService(SocketEvents events, {String? urlString}) {
    instance = SocketService._(events, urlString: urlString);
    return instance;
  }
  bool isRequested = false;

  final baseUrl = "ws://172.xx.x.xxx:xxxx/ws";
  var url = "";
  SocketService._(this.events, {String? urlString}) {

    initSocket();

  }

  Future initSocket() async {

    print("Init Socket");

    await WebSocket.connect(baseUrl).then((value){

      socket = value;
      connect();
      connected = true;
      events.onConnect();
    });
  }


  sendMessage(Map<String, dynamic> data,) {
    socket?.add(json.encode(data));
  }

  connect()  {

    socket?.listen((message) {

      events.onData(message);


    },onError: (e){
      connected = false;
      print(e);
      print("==================");
    } );


  }


  disconnect() {
    // socket.disconnect();
  }
}
