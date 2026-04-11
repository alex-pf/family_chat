// ignore_for_file: deprecated_member_use

import 'package:family_chat_sp_client/family_chat_sp_client.dart' as sp;
import 'package:flutter/material.dart';

import '../../main.dart';

/// Экран управления чатами (для Admin)
class AdminChatsScreen extends StatefulWidget {
  const AdminChatsScreen({super.key});

  @override
  State<AdminChatsScreen> createState() => _AdminChatsScreenState();
}

class _AdminChatsScreenState extends State<AdminChatsScreen> {
  List<sp.ChatAdminInfo> _chats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  Future<void> _loadChats() async {
    setState(() => _isLoading = true);
    try {
      final chats = await client.admin.listAllChats();
      if (mounted) setState(() => _chats = chats);
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

  Future<void> _showChatActionsDialog(sp.ChatAdminInfo chat) async {
    await showDialog<void>(
      context: context,
      builder: (_) => _ChatActionsDialog(
        chat: chat,
        onReload: () {
          Navigator.of(context).pop();
          _loadChats();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Чаты')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _chats.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 64,
                        color: colorScheme.outlineVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Нет чатов',
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadChats,
                  child: ListView.builder(
                    itemCount: _chats.length,
                    itemBuilder: (_, i) {
                      final chat = _chats[i];
                      final colorScheme = Theme.of(context).colorScheme;
                      return ListTile(
                        leading: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.group,
                            color: colorScheme.onSecondaryContainer,
                          ),
                        ),
                        title: Text(
                          chat.name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          '${chat.ownerName != null ? 'Владелец: ${chat.ownerName}' : 'Без владельца'}'
                          ' • ${chat.memberCount} уч.',
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                        trailing: Icon(
                          Icons.chevron_right,
                          color: colorScheme.outlineVariant,
                        ),
                        onTap: () => _showChatActionsDialog(chat),
                      );
                    },
                  ),
                ),
    );
  }
}

// ── Диалог действий с чатом ───────────────────────────────────────────────

class _ChatActionsDialog extends StatefulWidget {
  final sp.ChatAdminInfo chat;
  final VoidCallback onReload;

  const _ChatActionsDialog({required this.chat, required this.onReload});

  @override
  State<_ChatActionsDialog> createState() => _ChatActionsDialogState();
}

class _ChatActionsDialogState extends State<_ChatActionsDialog> {
  bool _archiving = false;
  bool _deleting = false;

  List<sp.AppUser> _allUsers = [];
  sp.AppUser? _selectedOwner;
  bool _loadingUsers = false;
  bool _savingOwner = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => _loadingUsers = true);
    try {
      final users = await client.user.listAllUsers();
      if (mounted) setState(() => _allUsers = users);
    } catch (_) {
      // Смена владельца будет недоступна
    } finally {
      if (mounted) setState(() => _loadingUsers = false);
    }
  }

  Future<void> _archiveChat() async {
    setState(() => _archiving = true);
    try {
      await client.admin.archiveChat(widget.chat.id);
      widget.onReload();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка архивации: $e')),
        );
        setState(() => _archiving = false);
      }
    }
  }

  Future<void> _deleteChat() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Удалить чат навсегда?'),
        content: Text(
          'Чат «${widget.chat.name}» и все его сообщения будут удалены безвозвратно.',
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

    if (confirmed != true || !mounted) return;

    setState(() => _deleting = true);
    try {
      await client.admin.deleteArchivedChat(widget.chat.id);
      widget.onReload();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка удаления: $e')),
        );
        setState(() => _deleting = false);
      }
    }
  }

  Future<void> _saveOwner() async {
    if (_selectedOwner == null) return;
    setState(() => _savingOwner = true);
    try {
      await client.admin.changeOwner(widget.chat.id, _selectedOwner!.id!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Владелец изменён на ${_selectedOwner!.name}'),
          ),
        );
        widget.onReload();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка смены владельца: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _savingOwner = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final chat = widget.chat;

    return AlertDialog(
      title: Text(chat.name),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${chat.memberCount} участников'
              '${chat.ownerName != null ? ' • Владелец: ${chat.ownerName}' : ''}',
              style: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 12),

            // ── Смена владельца ──────────────────────────────────────
            Text(
              'Сменить владельца:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            _loadingUsers
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : DropdownButtonFormField<sp.AppUser>(
                    value: _selectedOwner,
                    hint: Text(
                      chat.ownerName ?? 'Выберите пользователя',
                      style: TextStyle(color: cs.onSurfaceVariant),
                    ),
                    items: _allUsers
                        .map((u) => DropdownMenuItem<sp.AppUser>(
                              value: u,
                              child: Text('${u.name} (${u.email})'),
                            ))
                        .toList(),
                    onChanged: (sp.AppUser? u) =>
                        setState(() => _selectedOwner = u),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: (_selectedOwner == null || _savingOwner)
                    ? null
                    : _saveOwner,
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 44)),
                child: _savingOwner
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Назначить владельца'),
              ),
            ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),

            // ── Архивация / Удаление ─────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _archiving ? null : _archiveChat,
                icon: _archiving
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.archive_outlined),
                label: const Text('Архивировать чат'),
                style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 44)),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _deleting ? null : _deleteChat,
                icon: _deleting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.delete_outline),
                label: const Text('Удалить чат'),
                style: FilledButton.styleFrom(
                  backgroundColor: cs.error,
                  foregroundColor: cs.onError,
                  minimumSize: const Size(0, 44),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Закрыть'),
        ),
      ],
    );
  }
}
