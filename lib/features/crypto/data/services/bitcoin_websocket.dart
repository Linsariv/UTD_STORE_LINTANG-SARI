import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class BitcoinWebSocketService {
  // GANTI URL ke Binance (lebih stabil)
  static const String _wsUrl = 'wss://stream.binance.com:9443/ws/btcusdt@trade';
  WebSocketChannel? _channel;
  
  void connect(Function(double price) onPriceReceived) {
    try {
      print('Connecting to Binance WebSocket...');
      
      _channel = WebSocketChannel.connect(Uri.parse(_wsUrl));
      
      _channel!.stream.listen(
        (message) {
          print('Raw message: $message');
          
          final data = jsonDecode(message);
          
          // Binance format: {"p":"79622.00", ...}
          if (data['p'] != null) {
            final price = double.parse(data['p'].toString());
            print('Bitcoin price (Binance): $price');
            onPriceReceived(price);
          }
        },
        onError: (error) {
          print('WebSocket error: $error');
        },
        onDone: () {
          print('WebSocket disconnected');
        },
      );
    } catch (e) {
      print('Connection error: $e');
    }
  }
  
  void disconnect() {
    _channel?.sink.close();
  }
}