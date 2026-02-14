import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicina_app/core/routes/app_routes.dart';
import 'package:telemedicina_app/core/theme/app_colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
                  AppColors.welcomeGradientTop,
                  AppColors.welcomeGradientMid,
                  AppColors.welcomeGradientBottom,
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
            child: Column(
              children: [
                const SizedBox(height: 40),
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: [
                      Expanded(
                        child: _ActionTile(
                          icon: Icons.chat_bubble_outline,
                          label: 'Soy Socio',
                          onTap: () => Get.toNamed(Routes.login),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(width: 1, height: 60, color: AppColors.divider),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _ActionTile(
                          icon: Icons.person_outline,
                          label: 'Registrarme',
                          onTap: () => Get.toNamed(Routes.register),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () => Get.snackbar(
                    'Ayuda',
                    'Contacta a soporte para asistencia.',
                  ),
                  child: const Text(
                    'Necesitas ayuda?',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Icon(icon, size: 36, color: AppColors.primaryDark),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
