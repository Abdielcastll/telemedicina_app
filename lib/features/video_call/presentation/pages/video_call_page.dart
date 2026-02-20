import 'package:flutter/material.dart';

class VideoCallPage extends StatelessWidget {
  const VideoCallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Video llamada')),
      body: const Center(child: Text('Pantalla fake de video llamada')),
    );
  }
}
