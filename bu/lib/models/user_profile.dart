enum UserRole { tenant, landlord }

extension UserRoleX on UserRole {
  String get friendlyName => switch (this) {
    UserRole.tenant => 'Tenant',
    UserRole.landlord => 'Landlord',
  };
}

class UserProfile {
  UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.createdAt,
  });

  final String id;
  final String fullName;
  final String email;
  final UserRole role;
  final DateTime createdAt;

  UserProfile copyWith({
    String? id,
    String? fullName,
    String? email,
    UserRole? role,
    DateTime? createdAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
