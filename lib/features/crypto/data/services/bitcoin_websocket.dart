// lib/features/crypto/data/services/bitcoin_websocket.dart
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class BitcoinWebSocketService {
  static const String _wsUrl = 'wss://ws.coincap.io/prices?assets=bitcoin';
  WebSocketChannel? _channel;
  
  void connect(Function(double price) onPriceReceived) {
    _channel = WebSocketChannel.connect(Uri.parse(_wsUrl));
    
    _channel!.stream.listen((message) {
      final data = jsonDecode(message);
      if (data['bitcoin'] != null) {
        final price = double.parse(data['bitcoin'].toString());
        onPriceReceived(price);
      }
    });
  }
  
  void disconnect() {
    _channel?.sink.close();
  }
}