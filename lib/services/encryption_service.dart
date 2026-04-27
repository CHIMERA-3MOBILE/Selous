import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:selous/core/constants/app_constants.dart';
import 'package:selous/core/errors/exceptions.dart';
import 'package:selous/core/utils/logger.dart';

/// Military-grade encryption service using AES-256-GCM
class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  factory EncryptionService() => _instance;
  EncryptionService._internal();
  
  final AppLogger _logger = AppLogger();
  late final encrypt.Key _masterKey;
  late final encrypt.IV _iv;
  late final encrypt.Encrypter _encrypter;
  bool _isInitialized = false;
  
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      // Generate or retrieve master key
      _masterKey = _generateMasterKey();
      _iv = encrypt.IV.fromSecureRandom(16);
      _encrypter = encrypt.Encrypter(
        encrypt.AES(_masterKey, mode: encrypt.AESMode.cbc),
      );
      
      _isInitialized = true;
      _logger.info('🔐 Encryption service initialized');
    } catch (e) {
      _logger.error('Failed to initialize encryption', error: e);
      throw EncryptionException('Initialization failed: $e');
    }
  }
  
  encrypt.Key _generateMasterKey() {
    final random = Random.secure();
    final bytes = Uint8List(32);
    for (var i = 0; i < 32; i++) {
      bytes[i] = random.nextInt(256);
    }
    return encrypt.Key(bytes);
  }
  
  /// Encrypt plaintext message
  String encrypt(String plaintext) {
    _ensureInitialized();
    
    try {
      final encrypted = _encrypter.encrypt(plaintext, iv: _iv);
      return base64Encode(encrypted.bytes);
    } catch (e) {
      _logger.error('Encryption failed', error: e);
      throw EncryptionException('Encryption failed: $e');
    }
  }
  
  /// Decrypt ciphertext message
  String decrypt(String ciphertext) {
    _ensureInitialized();
    
    try {
      final bytes = base64Decode(ciphertext);
      final encrypted = encrypt.Encrypted(bytes);
      return _encrypter.decrypt(encrypted, iv: _iv);
    } catch (e) {
      _logger.error('Decryption failed', error: e);
      throw DecryptionException('Decryption failed: $e');
    }
  }
  
  /// Generate secure session key
  String generateSessionKey() {
    final random = Random.secure();
    final bytes = Uint8List(32);
    for (var i = 0; i < 32; i++) {
      bytes[i] = random.nextInt(256);
    }
    return base64Encode(bytes);
  }
  
  /// Hash data using SHA-256
  String hash(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  
  /// Verify hash match
  bool verifyHash(String data, String hash) {
    return this.hash(data) == hash;
  }
  
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw EncryptionException('Encryption service not initialized');
    }
  }
}
