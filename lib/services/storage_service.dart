import 'package:hive_flutter/hive_flutter.dart';
import 'package:selous/core/constants/app_constants.dart';
import 'package:selous/core/errors/exceptions.dart';
import 'package:selous/core/utils/logger.dart';

/// Local storage service using Hive
class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();
  
  final AppLogger _logger = AppLogger();
  bool _isInitialized = false;
  
  late Box<dynamic> _settingsBox;
  late Box<dynamic> _messagesBox;
  late Box<dynamic> _devicesBox;
  
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
      await Hive.initFlutter(AppConstants.dbName);
      
      _settingsBox = await Hive.openBox('settings');
      _messagesBox = await Hive.openBox('messages');
      _devicesBox = await Hive.openBox('devices');
      
      _isInitialized = true;
      _logger.info('💾 Storage service initialized');
    } catch (e) {
      _logger.error('Storage initialization failed', error: e);
      throw StorageException('Initialization failed: $e');
    }
  }
  
  // Settings
  Future<void> setSetting(String key, dynamic value) async {
    _ensureInitialized();
    await _settingsBox.put(key, value);
  }
  
  T? getSetting<T>(String key) {
    _ensureInitialized();
    return _settingsBox.get(key) as T?;
  }
  
  Future<void> removeSetting(String key) async {
    _ensureInitialized();
    await _settingsBox.delete(key);
  }
  
  // Messages
  Future<void> saveMessage(String id, Map<String, dynamic> message) async {
    _ensureInitialized();
    await _messagesBox.put(id, message);
  }
  
  Map<String, dynamic>? getMessage(String id) {
    _ensureInitialized();
    return _messagesBox.get(id) as Map<String, dynamic>?;
  }
  
  List<Map<String, dynamic>> getAllMessages() {
    _ensureInitialized();
    return _messagesBox.values
        .map((v) => v as Map<String, dynamic>)
        .toList();
  }
  
  Future<void> deleteMessage(String id) async {
    _ensureInitialized();
    await _messagesBox.delete(id);
  }
  
  // Devices
  Future<void> saveDevice(String id, Map<String, dynamic> device) async {
    _ensureInitialized();
    await _devicesBox.put(id, device);
  }
  
  Map<String, dynamic>? getDevice(String id) {
    _ensureInitialized();
    return _devicesBox.get(id) as Map<String, dynamic>?;
  }
  
  List<Map<String, dynamic>> getAllDevices() {
    _ensureInitialized();
    return _devicesBox.values
        .map((v) => v as Map<String, dynamic>)
        .toList();
  }
  
  Future<void> deleteDevice(String id) async {
    _ensureInitialized();
    await _devicesBox.delete(id);
  }
  
  Future<void> clearAll() async {
    _ensureInitialized();
    await _settingsBox.clear();
    await _messagesBox.clear();
    await _devicesBox.clear();
    _logger.info('🗑️ All storage cleared');
  }
  
  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StorageException('Storage service not initialized');
    }
  }
}
