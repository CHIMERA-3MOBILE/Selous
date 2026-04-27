import 'package:equatable/equatable.dart';

/// Represents a connected device in the mesh network
class Device extends Equatable {
  final String id;
  final String name;
  final String endpointId;
  final DeviceStatus status;
  final DateTime connectedAt;
  final DateTime? lastSeen;
  final Map<String, dynamic>? metadata;
  
  const Device({
    required this.id,
    required this.name,
    required this.endpointId,
    this.status = DeviceStatus.connected,
    required this.connectedAt,
    this.lastSeen,
    this.metadata,
  });
  
  Device copyWith({
    String? id,
    String? name,
    String? endpointId,
    DeviceStatus? status,
    DateTime? connectedAt,
    DateTime? lastSeen,
    Map<String, dynamic>? metadata,
  }) {
    return Device(
      id: id ?? this.id,
      name: name ?? this.name,
      endpointId: endpointId ?? this.endpointId,
      status: status ?? this.status,
      connectedAt: connectedAt ?? this.connectedAt,
      lastSeen: lastSeen ?? this.lastSeen,
      metadata: metadata ?? this.metadata,
    );
  }
  
  @override
  List<Object?> get props => [id, name, endpointId, status, connectedAt, lastSeen, metadata];
}

enum DeviceStatus {
  connected,
  disconnected,
  connecting,
  error,
}

extension DeviceStatusX on DeviceStatus {
  String get displayName {
    switch (this) {
      case DeviceStatus.connected:
        return 'Connected';
      case DeviceStatus.disconnected:
        return 'Disconnected';
      case DeviceStatus.connecting:
        return 'Connecting';
      case DeviceStatus.error:
        return 'Error';
    }
  }
  
  bool get isConnected => this == DeviceStatus.connected;
  bool get isDisconnected => this == DeviceStatus.disconnected;
}
