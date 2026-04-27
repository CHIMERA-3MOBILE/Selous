import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selous/core/utils/logger.dart';
import 'package:selous/domain/entities/device.dart';
import 'package:selous/domain/entities/message.dart';
import 'package:selous/services/encryption_service.dart';
import 'package:selous/services/network_service.dart';

part 'app_event.dart';
part 'app_state.dart';

/// Main application BLoC managing global state
class AppBloc extends Bloc<AppEvent, AppState> {
  final NetworkService _networkService;
  final EncryptionService _encryptionService;
  final AppLogger _logger = AppLogger();
  
  StreamSubscription? _deviceSubscription;
  StreamSubscription? _messageSubscription;
  StreamSubscription? _connectionSubscription;
  
  AppBloc({
    required NetworkService networkService,
    required EncryptionService encryptionService,
  })  : _networkService = networkService,
        _encryptionService = encryptionService,
        super(const AppState()) {
    on<AppStarted>(_onAppStarted);
    on<NetworkToggleRequested>(_onNetworkToggleRequested);
    on<DeviceConnected>(_onDeviceConnected);
    on<DeviceDisconnected>(_onDeviceDisconnected);
    on<MessageReceived>(_onMessageReceived);
    on<MessageSent>(_onMessageSent);
    on<ConnectionStatusChanged>(_onConnectionStatusChanged);
    on<ErrorOccurred>(_onErrorOccurred);
  }
  
  Future<void> _onAppStarted(AppStarted event, Emitter<AppState> emit) async {
    _logger.info('App initialization started');
    emit(state.copyWith(status: AppStatus.initializing));
    
    try {
      // Setup listeners
      _deviceSubscription = _networkService.deviceStream.listen(
        (device) => add(DeviceConnected(device)),
        onError: (e) => add(ErrorOccurred(e.toString())),
      );
      
      _messageSubscription = _networkService.messageStream.listen(
        (message) => add(MessageReceived(message)),
        onError: (e) => add(ErrorOccurred(e.toString())),
      );
      
      _connectionSubscription = _networkService.connectionStatusStream.listen(
        (status) => add(ConnectionStatusChanged(status)),
        onError: (e) => add(ErrorOccurred(e.toString())),
      );
      
      _logger.info('App initialization completed');
      emit(state.copyWith(status: AppStatus.ready));
    } catch (e) {
      _logger.error('App initialization failed', error: e);
      emit(state.copyWith(
        status: AppStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
  
  Future<void> _onNetworkToggleRequested(
    NetworkToggleRequested event,
    Emitter<AppState> emit,
  ) async {
    try {
      if (state.isNetworkActive) {
        await _networkService.stop();
        emit(state.copyWith(
          isNetworkActive: false,
          status: AppStatus.ready,
        ));
        _logger.info('Network stopped');
      } else {
        await _networkService.start();
        emit(state.copyWith(
          isNetworkActive: true,
          status: AppStatus.ready,
        ));
        _logger.info('Network started');
      }
    } catch (e) {
      _logger.error('Network toggle failed', error: e);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
  
  void _onDeviceConnected(DeviceConnected event, Emitter<AppState> emit) {
    final devices = List<Device>.from(state.connectedDevices)
      ..add(event.device);
    emit(state.copyWith(connectedDevices: devices));
    _logger.info('Device connected: ${event.device.name}');
  }
  
  void _onDeviceDisconnected(DeviceDisconnected event, Emitter<AppState> emit) {
    final devices = state.connectedDevices
        .where((d) => d.id != event.deviceId)
        .toList();
    emit(state.copyWith(connectedDevices: devices));
    _logger.info('Device disconnected: ${event.deviceId}');
  }
  
  void _onMessageReceived(MessageReceived event, Emitter<AppState> emit) {
    final messages = List<Message>.from(state.messages)
      ..add(event.message);
    emit(state.copyWith(messages: messages));
    _logger.info('Message received from: ${event.message.senderName}');
  }
  
  Future<void> _onMessageSent(
    MessageSent event,
    Emitter<AppState> emit,
  ) async {
    try {
      // Encrypt message
      final encrypted = _encryptionService.encrypt(event.content);
      
      // Send through network
      await _networkService.sendMessage(encrypted);
      
      // Add to local messages
      final message = Message(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        content: event.content,
        senderId: 'me',
        senderName: 'You',
        timestamp: DateTime.now(),
        isEncrypted: true,
        isMe: true,
      );
      
      final messages = List<Message>.from(state.messages)..add(message);
      emit(state.copyWith(messages: messages));
      _logger.info('Message sent');
    } catch (e) {
      _logger.error('Message send failed', error: e);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
  
  void _onConnectionStatusChanged(
    ConnectionStatusChanged event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(connectionStatus: event.status));
    _logger.info('Connection status: ${event.status}');
  }
  
  void _onErrorOccurred(ErrorOccurred event, Emitter<AppState> emit) {
    _logger.error(event.message);
    emit(state.copyWith(errorMessage: event.message));
  }
  
  @override
  Future<void> close() {
    _deviceSubscription?.cancel();
    _messageSubscription?.cancel();
    _connectionSubscription?.cancel();
    return super.close();
  }
}
