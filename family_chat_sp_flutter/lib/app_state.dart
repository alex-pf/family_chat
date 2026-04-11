import 'package:flutter/foundation.dart';

import 'main.dart';

/// Роль пользователя в системе
enum UserRole { admin, master, family, parents, children, guests, friends }

/// Простая модель профиля текущего пользователя
class AppUser {
  final int id;
  final String email;
  final String name;
  final String? avatarUrl;
  final bool isBlocked;
  final bool mustChangePassword;

  const AppUser({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    this.isBlocked = false,
    this.mustChangePassword = false,
  });

  String get initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

/// Глобальное состояние приложения
class AppState extends ChangeNotifier {
  AppUser? currentUser;
  List<UserRole> myRoles = [];

  bool get isAdmin => myRoles.contains(UserRole.admin);
  bool get isMaster => myRoles.contains(UserRole.master);
  bool get isFamily => myRoles.contains(UserRole.family);
  bool get isAuthenticated => currentUser != null;

  /// Загружает профиль текущего пользователя с сервера.
  /// TODO: после serverpod generate заменить заглушку на:
  ///   final profile = await client.user.getProfile();
  ///   currentUser = AppUser(id: profile.id, email: profile.email, name: profile.name, ...);
  ///   myRoles = profile.roles.map((r) => UserRole.values.byName(r.name.toLowerCase())).toList();
  Future<void> loadCurrentUser() async {
    try {
      final profile = await client.user.getMyProfile();
      final roleNames = await client.user.getMyRoles();
      currentUser = AppUser(
        id: profile.id!,
        email: profile.email,
        name: profile.name,
        isBlocked: profile.isBlocked,
        mustChangePassword: profile.mustChangePassword,
      );
      myRoles = roleNames
          .map((r) {
            try {
              return UserRole.values.byName(r.toLowerCase());
            } catch (_) {
              return null;
            }
          })
          .whereType<UserRole>()
          .toList();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Сбрасывает состояние при выходе
  void clear() {
    currentUser = null;
    myRoles = [];
    notifyListeners();
  }
}

/// Глобальный синглтон состояния приложения
final appState = AppState();
