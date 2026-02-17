import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicina_app/features/home/presentation/getx/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta medica'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: controller.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!controller.hasDoctorAvailable.value) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                controller.availabilityMessage.value,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Motivo de la consulta',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: controller.selectedReason.value,
                    decoration: const InputDecoration(
                      labelText: 'Selecciona una opción',
                      border: OutlineInputBorder(),
                    ),
                    items: HomeController.predefinedReasons
                        .map(
                          (reason) => DropdownMenuItem<String>(
                            value: reason,
                            child: Text(reason),
                          ),
                        )
                        .toList(),
                    onChanged: controller.setReason,
                  ),
                  const SizedBox(height: 12),
                  if (controller.isOtherReasonSelected)
                    TextFormField(
                      minLines: 3,
                      maxLines: 4,
                      onChanged: (value) =>
                          controller.otherSymptoms.value = value,
                      decoration: const InputDecoration(
                        labelText: 'Describe tus síntomas',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  if (controller.isOtherReasonSelected)
                    const SizedBox(height: 12),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: controller.submitConsultation,
                      child: const Text('Guardar motivo'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
