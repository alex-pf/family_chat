import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../../widgets/user_avatar.dart';

/// Модель пользователя для UI администратора
class AdminUserModel {
  final int id;
  final String name;
  final String email;
  final List<UserRole> roles;
  final bool isBlocked;

  const AdminUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    this.isBlocked = false,
  });
}

/// Экран управления пользователями (для Admin)
class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  List<AdminUserModel> _users = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoading = true);
    try {
      // TODO: после serverpod generate:
      // final users = await client.admin.getUsers();
      // setState(() { _users = users.map(...).toList(); });

      // Заглушка
      setState(() {
        _users = [
          AdminUserModel(
            id: 1,
            name: 'Администратор',
            email: 'admin@family.local',
            roles: [UserRole.admin],
          ),
          AdminUserModel(
            id: 2,
            name: 'Мама',
            email: 'mama@family.local',
            roles: [UserRole.master],
          ),
          AdminUserModel(
            id: 3,
            name: 'Папа',
            email: 'papa@family.local',
            roles: [UserRole.master],
          ),
          AdminUserModel(
            id: 4,
            name: 'Дочка',
            email: 'dochka@family.local',
            roles: [UserRole.family],
          ),
          AdminUserModel(
            id: 5,
            name: 'Сын',
            email: 'son@family.local',
            roles: [UserRole.family],
            isBlocked: true,
          ),
        ];
      });
    } catch (e) {
      debugPrint('Error loading users: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<AdminUserModel> get _filteredUsers {
    if (_searchQuery.isEmpty) return _users;
    final q = _searchQuery.toLowerCase();
    return _users.where((u) {
      return u.name.toLowerCase().contains(q) ||
          u.email.toLowerCase().contains(q);
    }).toList();
  }

  Future<void> _showCreateUserDialog() async {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    UserRole selectedRole = UserRole.family;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Создать пользователя'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Имя'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration:
                      const InputDecoration(labelText: 'Начальный пароль'),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<UserRole>(
                  value: selectedRole,
                  decoration: const InputDecoration(labelText: 'Роль'),
                  items: UserRole.values.map((r) {
                    return DropdownMenuItem(
                      value: r,
                      child: Text(_roleName(r)),
                    );
                  }).toList(),
                  onChanged: (r) =>
                      setDialogState(() => selectedRole = r!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Отмена'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
              onPressed: () async {
                // TODO: await client.admin.createUser(
                //   name: nameController.text,
                //   email: emailController.text,
                //   password: passwordController.text,
                //   role: selectedRole.name,
                // );
                Navigator.of(ctx).pop();
                _loadUsers();
              },
              child: const Text('Создать'),
            ),
          ],
        ),
      ),
    );

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> _showManageUserDialog(AdminUserModel user) async {
    List<UserRole> selectedRoles = List.from(user.roles);
    bool isBlocked = user.isBlocked;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text('Управление: ${user.name}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Роли:', style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: UserRole.values.map((role) {
                    final selected = selectedRoles.contains(role);
                    return FilterChip(
                      label: Text(_roleName(role)),
                      selected: selected,
                      onSelected: (v) {
                        setDialogState(() {
                          if (v) {
                            selectedRoles.add(role);
                          } else {
                            selectedRoles.remove(role);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Divider(),
                SwitchListTile(
                  title: const Text('Заблокирован'),
                  subtitle: isBlocked
                      ? const Text('Пользователь не может войти')
                      : null,
                  value: isBlocked,
                  onChanged: (v) => setDialogState(() => isBlocked = v),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Отмена'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
              onPressed: () async {
                // TODO: await client.admin.updateUser(
                //   userId: user.id,
                //   roles: selectedRoles.map((r) => r.name).toList(),
                //   isBlocked: isBlocked,
                // );
                Navigator.of(ctx).pop();
                _loadUsers();
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }

  String _roleName(UserRole role) {
    switch (role) {
      case UserRole.admin:    return 'Администратор';
      case UserRole.master:   return 'Мастер';
      case UserRole.family:   return 'Семья';
      case UserRole.parents:  return 'Родители';
      case UserRole.children: return 'Дети';
      case UserRole.guests:   return 'Гости';
      case UserRole.friends:  return 'Друзья';
    }
  }

  Color _roleColor(UserRole role, ColorScheme cs) {
    switch (role) {
      case UserRole.admin:    return cs.errorContainer;
      case UserRole.master:   return cs.primaryContainer;
      case UserRole.family:   return cs.secondaryContainer;
      case UserRole.parents:  return cs.tertiaryContainer;
      case UserRole.children: return cs.surfaceContainerHighest;
      case UserRole.guests:   return cs.surfaceContainerHigh;
      case UserRole.friends:  return cs.surfaceContainer;
    }
  }

  Color _roleTextColor(UserRole role, ColorScheme cs) {
    switch (role) {
      case UserRole.admin:    return cs.onErrorContainer;
      case UserRole.master:   return cs.onPrimaryContainer;
      case UserRole.family:   return cs.onSecondaryContainer;
      case UserRole.parents:  return cs.onTertiaryContainer;
      case UserRole.children: return cs.onSurface;
      case UserRole.guests:   return cs.onSurface;
      case UserRole.friends:  return cs.onSurface;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Пользователи'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Поиск по имени или email...',
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withAlpha(80),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _filteredUsers.isEmpty
              ? Center(
                  child: Text(
                    'Нет пользователей',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                )
              : ListView.builder(
                  itemCount: _filteredUsers.length,
                  itemBuilder: (_, i) {
                    final user = _filteredUsers[i];
                    return ListTile(
                      leading: UserAvatar(
                        name: user.name,
                        userId: user.id,
                        size: 44,
                        isBlocked: user.isBlocked,
                      ),
                      title: Opacity(
                        opacity: user.isBlocked ? 0.5 : 1.0,
                        child: Text(
                          user.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.email,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 4,
                            children: user.roles.map((r) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: _roleColor(r, colorScheme),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  _roleName(r),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: _roleTextColor(r, colorScheme),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                      trailing: Icon(
                        Icons.chevron_right,
                        color: colorScheme.outlineVariant,
                      ),
                      onTap: () => _showManageUserDialog(user),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateUserDialog,
        child: const Icon(Icons.person_add_outlined),
      ),
    );
  }
}
