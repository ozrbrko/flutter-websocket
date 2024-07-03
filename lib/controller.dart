import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_app/socket_model.dart';
import 'package:web_socket_app/socket_service.dart';

class ExampleScreenController extends GetxController with SocketEvents  {
  RxBool loading = false.obs;
  RxBool waitingText = false.obs;
  late Timer timer;
  RxInt currentTime = 25.obs;
  RxBool keyboardStatus = false.obs;
  late SocketService socketService;
  String message = '';

  bool initializing = false;

  @override
  onInit() {

    socketService = SocketService(this);
    super.onInit();
  }





  riceOrderFunction() async {

    // if(initializing){
    //   Get.snackbar("UYARI", "Bağlantı Kuruluyor, Lütfen Bekleyiniz.",
    //       snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.yellow,duration: 2.seconds);
    //   return;
    // }
    if(!socketService.connected){

      Get.snackbar("HATA", "Socket bağlantısı mevcut değil, tekrar bağlantı kuruluyor!",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red,duration: 3.seconds);

      // initializing = true;
      await socketService.initSocket();
      // initializing = false;
    }

    socketService.sendMessage({"command":"GIVE_RICE_ALL","data":""});
    startTimer();
  }

  void startTimer() {
    waitingText.value = true;
  }

  @override
  void onConnect() {
    print("Connected");
  }

  @override
  void onData(data) {


    print(data);

    final parsedData = WsMessage.fromJson(json.decode(data));
    message = parsedData.data.toString();
    _showSnackBar(message, parsedData.notifyType);


    if(parsedData.command == ECommand.COMMAND_A){
      waitingText.value = false;
    }


    // _handleNotification(parsedData.notifyType, message);
    // _showSnackBar(data);
  }

  @override
  void onDisconnect() {
  }


  _showSnackBar(String data, ENotifyType notifyType) {



    switch (notifyType) {
      case ENotifyType.ERROR:
        Get.snackbar("HATA", data,
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red,duration: 2.seconds);
        break;
      case ENotifyType.SUCCESS:
        Get.snackbar("BAŞARILI", data,
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green,duration: 2.seconds);
        break;
      case ENotifyType.WARNING:
        Get.snackbar("UYARI", data,
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.yellow,duration: 2.seconds);
        break;
      case ENotifyType.INFO:
      //   Get.snackbar("BİLGİ", data,
      //       snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.blueAccent,duration: 0.8.seconds);

        print(data);

    }

  }
}