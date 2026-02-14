import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicina_app/features/home/presentation/getx/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(child: Text('Bienvenido a Telemedicina')),
    );
  }
}
