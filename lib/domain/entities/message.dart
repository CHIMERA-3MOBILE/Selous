import 'package:equatable/equatable.dart';

/// Represents a message in the secure communication system
class Message extends Equatable {
  final String id;
  final String content;
  final String senderId;
  final String senderName;
  final String? recipientId;
  final DateTime timestamp;
  final MessageStatus status;
  final bool isEncrypted;
  final bool isMe;
  final Map<String, dynamic>? metadata;
  
  const Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.senderName,
    this.recipientId,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.isEncrypted = true,
    this.isMe = false,
    this.metadata,
  });
  
  Message copyWith({
    String? id,
    String? content,
    String? senderId,
    String? senderName,
    String? recipientId,
    DateTime? timestamp,
    MessageStatus? status,
    bool? isEncrypted,
    bool? isMe,
    Map<String, dynamic>? metadata,
  }) {
    return Message(
      id: id ?? this.id,
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      recipientId: recipientId ?? this.recipientId,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      isMe: isMe ?? this.isMe,
      metadata: metadata ?? this.metadata,
    );
  }
  
  @override
  List<Object?> get props => [
        id,
        content,
        senderId,
        senderName,
        recipientId,
        timestamp,
        status,
        isEncrypted,
        isMe,
        metadata,
      ];
}

enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}

extension MessageStatusX on MessageStatus {
  String get displayName {
    switch (this) {
      case MessageStatus.sending:
        return 'Sending';
      case MessageStatus.sent:
        return 'Sent';
      case MessageStatus.delivered:
        return 'Delivered';
      case MessageStatus.read:
        return 'Read';
      case MessageStatus.failed:
        return 'Failed';
    }
  }
  
  bool get isPending => this == MessageStatus.sending;
  bool get isDelivered => this == MessageStatus.delivered || this == MessageStatus.read;
}
