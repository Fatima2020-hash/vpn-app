// shadows.dart
import 'package:flutter/material.dart';

class AppShadows {
  // Slight shadow for light elevation effect
  static const BoxShadow slightShadow = BoxShadow(
    color: Colors.black12, // Light shadow
    offset: Offset(0, 1), // Slight vertical offset
    blurRadius: 4, // Soft shadow
    spreadRadius: 0, // No spread, just a soft shadow under the widget
  );

  // Default shadow for containers
  static BoxShadow containerShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1), // Light opacity shadow
    offset: Offset(0, 4), // Vertical shadow offset
    blurRadius: 8, // Blur softness
    spreadRadius: 2, // Shadow spread
  );

  // A deeper, more pronounced shadow
  static BoxShadow deepContainerShadow = BoxShadow(
    color: Colors.black.withOpacity(0.2), // Darker shadow
    offset: Offset(0, 6), // Increased vertical offset
    blurRadius: 12, // Larger blur radius
    spreadRadius: 3, // Slightly more spread
  );
}
