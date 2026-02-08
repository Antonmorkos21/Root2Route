import 'package:flutter/material.dart';

class FeatureCropModel {
  final String season;
  final String marketStatus;
  final IconData seasonIcon;
  final Color seasonColor;
  final IconData marketIcon;
  final Color marketColor;

  const FeatureCropModel({
    required this.season,
    required this.marketStatus,
    required this.seasonIcon,
    required this.seasonColor,
    required this.marketIcon,
    required this.marketColor,
  });
}
