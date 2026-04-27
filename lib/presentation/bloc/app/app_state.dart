part of 'app_bloc.dart';

enum AppStatus { initial, initializing, ready, error, offline }

class AppState extends Equatable {
  final AppStatus status;
  final bool isNetworkActive;
  final List<Device> connectedDevices;
  final List<Message> messages;
  final String connectionStatus;
  final String? errorMessage;
  
  const AppState({
    this.status = AppStatus.initial,
    this.isNetworkActive = false,
    this.connectedDevices = const [],
    this.messages = const [],
    this.connectionStatus = 'disconnected',
    this.errorMessage,
  });
  
  AppState copyWith({
    AppStatus? status,
    bool? isNetworkActive,
    List<Device>? connectedDevices,
    List<Message>? messages,
    String? connectionStatus,
    String? errorMessage,
  }) {
    return AppState(
      status: status ?? this.status,
      isNetworkActive: isNetworkActive ?? this.isNetworkActive,
      connectedDevices: connectedDevices ?? this.connectedDevices,
      messages: messages ?? this.messages,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [
        status,
        isNetworkActive,
        connectedDevices,
        messages,
        connectionStatus,
        errorMessage,
      ];
}
