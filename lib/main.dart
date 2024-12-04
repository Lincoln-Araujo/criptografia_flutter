import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Criptografia de Texto',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  String _encryptedText = '';
  String _decryptedText = '';
  final encrypt.Key keyAES = encrypt.Key.fromUtf8('my32lengthsupersecretnooneknows1');
  final encrypt.IV ivAES = encrypt.IV.fromLength(16);

  void _encryptAES() {
    final encrypter = encrypt.Encrypter(encrypt.AES(keyAES));
    final encrypted = encrypter.encrypt(_controller.text, iv: ivAES);
    setState(() {
      _encryptedText = encrypted.base64;
    });
  }

  void _decryptAES() {
    final encrypter = encrypt.Encrypter(encrypt.AES(keyAES));
    final decrypted = encrypter.decrypt64(_encryptedText, iv: ivAES);
    setState(() {
      _decryptedText = decrypted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criptografia de Texto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Digite o texto'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _encryptAES,
              child: Text('Criptografar (AES)'),
            ),
            ElevatedButton(
              onPressed: _decryptAES,
              child: Text('Descriptografar (AES)'),
            ),
            SizedBox(height: 16),
            Text('Texto Criptografado: $_encryptedText'),
            Text('Texto Descriptografado: $_decryptedText'),
          ],
        ),
      ),
    );
  }
}
