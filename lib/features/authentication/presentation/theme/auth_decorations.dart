import 'package:flutter/material.dart';
import 'package:telemedicina_app/core/theme/app_colors.dart';

class AuthDecorations {
  AuthDecorations._();

  static const BoxDecoration background = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.welcomeGradientTop,
        AppColors.welcomeGradientMid,
        AppColors.welcomeGradientBottom,
      ],
    ),
  );

  static final BoxDecoration formCard = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: const [
      BoxShadow(color: AppColors.shadow, blurRadius: 16, offset: Offset(0, 8)),
    ],
  );
}
