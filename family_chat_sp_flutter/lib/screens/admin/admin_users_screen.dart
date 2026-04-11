// ignore_for_file: deprecated_member_use

import 'package:family_chat_sp_client/family_chat_sp_client.dart' as sp;
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets/user_avatar.dart';
import 'create_user_dialog.dart';

/// Экран управления пользователями (для Admin)
class AdminUsersScreen extends StatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  State<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends State<AdminUsersScreen> {
  List<sp.AppUser> _users = [];
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
      final users = await client.user.listAllUsers();
      if (mounted) setState(() => _users = users);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка загрузки: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  List<sp.AppUser> get _filteredUsers {
    if (_searchQuery.isEmpty) return _users;
    final q = _searchQuery.toLowerCase();
    return _users.where((u) {
      return u.name.toLowerCase().contains(q) ||
          u.email.toLowerCase().contains(q);
    }).toList();
  }

  Future<void> _openCreateUserDialog() async {
    final created = await showDialog<sp.AppUser>(
      context: context,
      builder: (_) => const CreateUserDialog(),
    );
    if (created != null) {
      // Перезагружаем список и показываем снэкбар суспехом
      _loadUsers();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Пользователь «${created.name}» создан'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Future<void> _showManageUserDialog(sp.AppUser user) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _ManageUserDialog(
        user: user,
        onReload: _loadUsers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Пользователи'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilledButton.icon(
              onPressed: _openCreateUserDialog,
              icon: const Icon(Icons.person_add_outlined, size: 18),
              label: const Text('Добавить'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(0, 36),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 0),
              ),
            ),
          ),
        ],
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 64,
                        color: colorScheme.outlineVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _searchQuery.isEmpty
                            ? 'Нет пользователей'
                            : 'Ничего не найдено',
                        style:
                            TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadUsers,
                  child: ListView.builder(
                    itemCount: _filteredUsers.length,
                    itemBuilder: (_, i) {
                      final user = _filteredUsers[i];
                      return ListTile(
                        leading: UserAvatar(
                          name: user.name,
                          userId: user.id ?? 0,
                          size: 44,
                          isBlocked: user.isBlocked,
                        ),
                        title: Opacity(
                          opacity: user.isBlocked ? 0.5 : 1.0,
                          child: Text(
                            user.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        subtitle: Text(
                          user.email,
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (user.isBlocked)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: colorScheme.errorContainer,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Заблокирован',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: colorScheme.onErrorContainer,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right,
                              color: colorScheme.outlineVariant,
                            ),
                          ],
                        ),
                        onTap: () => _showManageUserDialog(user),
                      );
                    },
                  ),
                ),
    );
  }
}

// ── Диалог управления пользователем ─────────────────────────────────────────

class _ManageUserDialog extends StatefulWidget {
  final sp.AppUser user;
  final VoidCallback onReload;

  const _ManageUserDialog({required this.user, required this.onReload});

  @override
  State<_ManageUserDialog> createState() => _ManageUserDialogState();
}

class _ManageUserDialogState extends State<_ManageUserDialog> {
  List<sp.UserRole> _selectedRoles = [];
  bool _loadingRoles = true;
  bool _savingRoles = false;
  bool _savingBlock = false;
  bool _checkingDelete = false;
  bool? _hasChats; // true = есть чаты, false = нет, null = не проверено

  @override
  void initState() {
    super.initState();
    _loadRoles();
  }

  Future<void> _loadRoles() async {
    try {
      final roleNames = await client.admin.getUserRoles(widget.user.id!);
      final List<sp.UserRole> roles = roleNames
          .map<sp.UserRole?>((r) {
            try {
              return sp.UserRole.values.byName(r.toLowerCase());
            } catch (_) {
              return null;
            }
          })
          .whereType<sp.UserRole>()
          .toList();
      if (mounted) setState(() => _selectedRoles = roles);
    } catch (_) {
      // Оставляем пустой список — не критично
    } finally {
      if (mounted) setState(() => _loadingRoles = false);
    }
  }

  // ── Блокировка ─────────────────────────────────────────────────────────

  Future<void> _toggleBlock(bool block) async {
    setState(() => _savingBlock = true);
    try {
      if (block) {
        await client.admin.blockUser(widget.user.id!);
      } else {
        await client.admin.unblockUser(widget.user.id!);
      }
      if (mounted) Navigator.of(context).pop();
      widget.onReload();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
        setState(() => _savingBlock = false);
      }
    }
  }

  // ── Роли ───────────────────────────────────────────────────────────────

  Future<void> _saveRoles() async {
    if (_selectedRoles.isEmpty) return;
    setState(() => _savingRoles = true);
    try {
      await client.admin.assignRoles(widget.user.id!, _selectedRoles);
      if (mounted) Navigator.of(context).pop();
      widget.onReload();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка сохранения ролей: $e')),
        );
        setState(() => _savingRoles = false);
      }
    }
  }

  // ── Удаление ───────────────────────────────────────────────────────────

  Future<void> _checkAndDelete() async {
    setState(() => _checkingDelete = true);
    try {
      // Пробуем удалить — сервер проверит наличие чатов и вернёт ошибку
      // если они есть. Это единственная проверка, т.к. нет отдельного
      // admin.hasUserChats() endpoint.
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Удалить пользователя?'),
          content: Text(
            'Аккаунт «${widget.user.name}» (${widget.user.email}) '
            'будет удалён безвозвратно.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Отмена'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
                minimumSize: const Size(0, 44),
              ),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Удалить'),
            ),
          ],
        ),
      );

      if (confirmed != true || !mounted) {
        setState(() => _checkingDelete = false);
        return;
      }

      await client.admin.deleteUser(widget.user.id!);
      if (mounted) Navigator.of(context).pop();
      widget.onReload();
    } catch (e) {
      final errStr = e.toString();
      // Если сервер сообщил о чатах — блокируем кнопку и показываем тултип
      if (errStr.contains('chat')) {
        setState(() => _hasChats = true);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _hasChats == true
                  ? 'Нельзя удалить: пользователь участвует в чатах'
                  : 'Ошибка удаления: $errStr',
            ),
          ),
        );
        setState(() => _checkingDelete = false);
      }
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final user = widget.user;
    final deleteBlocked = _hasChats == true;

    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(user.name),
          Text(
            user.email,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Блокировка ──────────────────────────────────────────
            const Divider(),
            SwitchListTile(
              title:
                  Text(user.isBlocked ? 'Разблокировать' : 'Заблокировать'),
              subtitle: user.isBlocked
                  ? const Text('Пользователь не может войти')
                  : null,
              value: user.isBlocked,
              onChanged: _savingBlock ? null : _toggleBlock,
              secondary: _savingBlock
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      user.isBlocked
                          ? Icons.lock_outlined
                          : Icons.lock_open_outlined,
                      color: cs.onSurfaceVariant,
                    ),
              contentPadding: EdgeInsets.zero,
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),

            // ── Роли ─────────────────────────────────────────────────
            const Text(
              'Роли:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            _loadingRoles
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: sp.UserRole.values.map((role) {
                      final selected = _selectedRoles.contains(role);
                      return FilterChip(
                        label: Text(_roleName(role)),
                        selected: selected,
                        onSelected: (v) {
                          setState(() {
                            if (v) {
                              _selectedRoles.add(role);
                            } else {
                              _selectedRoles.remove(role);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),

            // ── Удаление ─────────────────────────────────────────────
            Tooltip(
              message: deleteBlocked
                  ? 'Нельзя удалить: есть чаты с участием этого пользователя'
                  : '',
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: (deleteBlocked || _checkingDelete)
                      ? null
                      : _checkAndDelete,
                  icon: _checkingDelete
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: cs.error),
                        )
                      : Icon(
                          Icons.delete_outline,
                          color: deleteBlocked ? null : cs.error,
                        ),
                  label: Text(
                    'Удалить пользователя',
                    style:
                        TextStyle(color: deleteBlocked ? null : cs.error),
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 44),
                    side: BorderSide(
                        color: deleteBlocked
                            ? cs.outlineVariant
                            : cs.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
          onPressed:
              (_savingRoles || _selectedRoles.isEmpty) ? null : _saveRoles,
          child: _savingRoles
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Сохранить роли'),
        ),
      ],
    );
  }

  String _roleName(sp.UserRole role) {
    switch (role) {
      case sp.UserRole.admin:
        return 'Администратор';
      case sp.UserRole.master:
        return 'Мастер';
      case sp.UserRole.family:
        return 'Семья';
      case sp.UserRole.parents:
        return 'Родители';
      case sp.UserRole.children:
        return 'Дети';
      case sp.UserRole.guests:
        return 'Гости';
      case sp.UserRole.friends:
        return 'Друзья';
    }
  }
}
