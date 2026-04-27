import 'package:equatable/equatable.dart';

/// Represents the current user/session
class User extends Equatable {
  final String id;
  final String displayName;
  final String? avatarUrl;
  final bool isAuthenticated;
  final DateTime createdAt;
  final Map<String, dynamic> settings;
  
  const User({
    required this.id,
    required this.displayName,
    this.avatarUrl,
    this.isAuthenticated = false,
    required this.createdAt,
    this.settings = const {},
  });
  
  User copyWith({
    String? id,
    String? displayName,
    String? avatarUrl,
    bool? isAuthenticated,
    DateTime? createdAt,
    Map<String, dynamic>? settings,
  }) {
    return User(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      createdAt: createdAt ?? this.createdAt,
      settings: settings ?? this.settings,
    );
  }
  
  @override
  List<Object?> get props => [
        id,
        displayName,
        avatarUrl,
        isAuthenticated,
        createdAt,
        settings,
      ];
}
