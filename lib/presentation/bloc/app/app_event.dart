part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
  
  @override
  List<Object?> get props => [];
}

class AppStarted extends AppEvent {
  const AppStarted();
}

class NetworkToggleRequested extends AppEvent {
  const NetworkToggleRequested();
}

class DeviceConnected extends AppEvent {
  final Device device;
  const DeviceConnected(this.device);
  
  @override
  List<Object?> get props => [device];
}

class DeviceDisconnected extends AppEvent {
  final String deviceId;
  const DeviceDisconnected(this.deviceId);
  
  @override
  List<Object?> get props => [deviceId];
}

class MessageReceived extends AppEvent {
  final Message message;
  const MessageReceived(this.message);
  
  @override
  List<Object?> get props => [message];
}

class MessageSent extends AppEvent {
  final String content;
  final String? recipientId;
  const MessageSent(this.content, {this.recipientId});
  
  @override
  List<Object?> get props => [content, recipientId];
}

class ConnectionStatusChanged extends AppEvent {
  final String status;
  const ConnectionStatusChanged(this.status);
  
  @override
  List<Object?> get props => [status];
}

class ErrorOccurred extends AppEvent {
  final String message;
  const ErrorOccurred(this.message);
  
  @override
  List<Object?> get props => [message];
}
