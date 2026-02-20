import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicina_app/core/res/media_res.dart';
import 'package:telemedicina_app/core/routes/app_routes.dart';
import 'package:telemedicina_app/core/theme/app_colors.dart';
import 'package:telemedicina_app/features/authentication/_export.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: AuthDecorations.background),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: const SizedBox.shrink(),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 48,
                    ),
                    child: Column(
                      children: [
                        Image.asset(MediaRes.logo, scale: 2.0),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 16,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Registrate',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => Get.back(),
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const TextField(
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  labelText: 'Nombre completo',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Correo',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const TextField(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'ID de Socio',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: 'Confirmar contraseña',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: () => Get.snackbar(
                                    'Registro',
                                    'Pantalla en construcción.',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Registrarme'),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: () => Get.offAllNamed(Routes.login),
                                child: const Text('Ya soy socio'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
