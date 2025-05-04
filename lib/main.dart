import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // ระบุ IP ของคอมพิวเตอร์ Windows ที่รัน server.py
  final String serverUrl =
      'http://192.168.1.100:5000/send'; // เปลี่ยน IP ตามจริง

  void sendData(String data) async {
    try {
      var response = await http.post(
        Uri.parse(serverUrl),
        body: {'data': data},
      );
      print('ส่งแล้ว: $data - ${response.statusCode}');
    } catch (e) {
      print('ส่งไม่สำเร็จ: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WiFi Button Sender',
      home: Scaffold(
        appBar: AppBar(title: Text('ส่งข้อมูลผ่าน Wi-Fi')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildButton('ส่ง 00', '00'),
              buildButton('ส่ง 01', '01'),
              buildButton('ส่ง 10', '10'),
              buildButton('ส่ง 11', '11'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        onPressed: () => sendData(value),
        child: Text(label, style: TextStyle(fontSize: 20)),
        style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 60)),
      ),
    );
  }
}
