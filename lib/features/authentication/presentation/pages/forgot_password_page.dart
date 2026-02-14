import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicina_app/core/routes/app_routes.dart';
import 'package:telemedicina_app/core/theme/app_colors.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.loginGradientTop,
                  AppColors.loginGradientMid,
                  AppColors.loginGradientBottom,
                ],
              ),
            ),
          ),
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
                    vertical: 24,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 48,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Column(
                          children: const [
                            Icon(
                              Icons.health_and_safety,
                              size: 64,
                              color: AppColors.primary,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'MediCabin',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'CUIDADO DE TU SALUD',
                              style: TextStyle(
                                letterSpacing: 1.2,
                                fontSize: 12,
                                color: AppColors.primaryMuted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
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
                                      'Recuperar contrasena',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        Get.offAllNamed(Routes.login),
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Te enviaremos un codigo para restablecer tu acceso.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: AppColors.black45),
                              ),
                              const SizedBox(height: 16),
                              const TextField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Correo o ID de Socio',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: () => Get.snackbar(
                                    'Recuperacion',
                                    'Funcion en construccion.',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    foregroundColor: AppColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text('Enviar codigo'),
                                ),
                              ),
                              const SizedBox(height: 12),
                              TextButton(
                                onPressed: () => Get.offAllNamed(Routes.login),
                                child: const Text('Volver a inicio de sesion'),
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
