import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicina_app/core/res/media_res.dart';
import 'package:telemedicina_app/core/routes/app_routes.dart';
import 'package:telemedicina_app/core/theme/app_colors.dart';
import 'package:telemedicina_app/features/authentication/_export.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
            child: Column(
              children: [
                const SizedBox(height: 40),
                Column(
                  children: [
                    SizedBox(height: 8),
                    Image.asset(MediaRes.logo, scale: 2.0),
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
                const Spacer(flex: 2),
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
