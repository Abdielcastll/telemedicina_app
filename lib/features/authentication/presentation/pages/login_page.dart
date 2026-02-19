import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicina_app/core/res/media_res.dart';
import 'package:telemedicina_app/core/routes/app_routes.dart';
import 'package:telemedicina_app/core/theme/app_colors.dart';
import 'package:telemedicina_app/features/authentication/presentation/getx/login_controller.dart';
import 'package:telemedicina_app/features/authentication/presentation/theme/auth_decorations.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

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
                    vertical: 24,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 48,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        Image.asset(MediaRes.logo, scale: 2.0),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                          decoration: AuthDecorations.formCard,
                          child: Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Identificate',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () =>
                                          Get.offAllNamed(Routes.welcome),
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) =>
                                      controller.username.value = value,
                                  decoration: const InputDecoration(
                                    labelText: 'ID de Socio',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Ingresa tu ID de socio.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                Obx(() {
                                  return TextFormField(
                                    obscureText: !controller.showPassword.value,
                                    onChanged: (value) =>
                                        controller.password.value = value,
                                    decoration: InputDecoration(
                                      labelText: 'Contrasena',
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            controller.showPassword.value =
                                                !controller.showPassword.value,
                                        icon: Icon(
                                          controller.showPassword.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Ingresa tu contrasena.';
                                      }
                                      if (value.length < 6) {
                                        return 'Minimo 6 caracteres.';
                                      }
                                      return null;
                                    },
                                  );
                                }),
                                const SizedBox(height: 12),
                                // const Text(
                                //   'Demo: adminMovil / adminMovil',
                                //   textAlign: TextAlign.center,
                                //   style: TextStyle(
                                //     color: AppColors.black45,
                                //     fontSize: 12,
                                //   ),
                                // ),
                                const SizedBox(height: 16),
                                Obx(() {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      if (controller
                                          .errorMessage
                                          .value
                                          .isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 12,
                                          ),
                                          child: Text(
                                            controller.errorMessage.value,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: AppColors.error,
                                            ),
                                          ),
                                        ),
                                      SizedBox(
                                        height: 44,
                                        child: ElevatedButton(
                                          onPressed: controller.isLoading.value
                                              ? null
                                              : () {
                                                  final isValid =
                                                      _formKey.currentState
                                                          ?.validate() ??
                                                      false;
                                                  if (!isValid) return;
                                                  controller.login();
                                                },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            foregroundColor: AppColors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: controller.isLoading.value
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color: AppColors.white,
                                                      ),
                                                )
                                              : const Text('Iniciar sesion'),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      TextButton(
                                        onPressed: () =>
                                            Get.toNamed(Routes.register),
                                        child: const Text('No soy socio'),
                                      ),
                                      // TextButton(
                                      //   onPressed: () =>
                                      //       Get.toNamed(Routes.forgotPassword),
                                      //   child: const Text(
                                      //     'Olvidaste tu contrasena?',
                                      //   ),
                                      // ),
                                    ],
                                  );
                                }),
                              ],
                            ),
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
