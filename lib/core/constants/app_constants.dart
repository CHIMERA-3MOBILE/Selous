import 'package:flutter/material.dart';

/// App-wide constants for SELous
class AppConstants {
  AppConstants._();
  
  // App Info
  static const String appName = 'SELous';
  static const String appTagline = 'Secure Encrypted Line of Universal Communication';
  static const String appVersion = '2.0.0';
  static const String appBuild = '100';
  
  // Colors
  static const Color primaryColor = Color(0xFF6C63FF);
  static const Color secondaryColor = Color(0xFF00BFA6);
  static const Color accentColor = Color(0xFFFF6584);
  static const Color darkColor = Color(0xFF2D2D3A);
  static const Color lightColor = Color(0xFFF8F9FA);
  static const Color errorColor = Color(0xFFE53935);
  static const Color successColor = Color(0xFF43A047);
  static const Color warningColor = Color(0xFFFFA726);
  
  // Networking
  static const String serviceId = 'com.selous.secure.mesh.v2';
 static const int maxConnections = 20;
  static const int maxMessageSize = 5 * 1024 * 1024; // 5MB
  static const int connectionTimeoutSeconds = 30;
  static const int retryAttempts = 5;
  static const Duration retryDelay = Duration(seconds: 2);
  
  // Encryption
  static const int aesKeySize = 32; // 256 bits
  static const int ivSize = 16; // 128 bits
  static const int pbkdf2Iterations = 100000;
  
  // UI
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 400);
  
  // Storage
  static const String dbName = 'selous_db';
  static const int dbVersion = 1;
}
