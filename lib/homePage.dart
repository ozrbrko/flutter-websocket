import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final channel = IOWebSocketChannel.connect("wss://stream.binance.com:9443/ws/btcusdt@trade");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    streamListener();
  }

  streamListener(){

    // Future.delayed(const Duration(seconds: 30), () {

    channel.stream.listen((message){
      Map getData = jsonDecode(message);
      setState(() {


          btcUsdtPrice = getData["p"];

        // second function

      });

      print(getData["p"]);

    }

    // );},

    );
  }


  String btcUsdtPrice = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BTC/USDT Price",style: TextStyle(fontWeight: FontWeight.bold,color:Colors.white,fontSize: 20),),
            Text(btcUsdtPrice,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.amber,fontSize: 20),)

          ],
        ),
      ),
    );
  }
}
