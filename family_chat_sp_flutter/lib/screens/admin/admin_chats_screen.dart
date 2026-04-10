import 'package:flutter/material.dart';

/// Модель чата для UI администратора
class AdminChatModel {
  final int id;
  final String name;
  final bool isGroup;
  final String ownerName;
  final int membersCount;
  final bool isArchived;

  const AdminChatModel({
    required this.id,
    required this.name,
    required this.isGroup,
    required this.ownerName,
    required this.membersCount,
    this.isArchived = false,
  });
}

/// Экран управления чатами (для Admin)
class AdminChatsScreen extends StatefulWidget {
  const AdminChatsScreen({super.key});

  @override
  State<AdminChatsScreen> createState() => _AdminChatsScreenState();
}

class _AdminChatsScreenState extends State<AdminChatsScreen> {
  List<AdminChatModel> _chats = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadChats();
  }

  Future<void> _loadChats() async {
    setState(() => _isLoading = true);
    try {
      // TODO: после serverpod generate:
      // final chats = await client.admin.getAllChats();
      // setState(() { _chats = chats.map(...).toList(); });

      // Заглушка
      setState(() {
        _chats = [
          AdminChatModel(
            id: 1,
            name: 'Вся семья',
            isGroup: true,
            ownerName: 'Администратор',
            membersCount: 5,
          ),
          AdminChatModel(
            id: 2,
            name: 'Мама — Папа',
            isGroup: false,
            ownerName: 'Мама',
            membersCount: 2,
          ),
          AdminChatModel(
            id: 3,
            name: 'Старый чат',
            isGroup: true,
            ownerName: 'Папа',
            membersCount: 3,
            isArchived: true,
          ),
        ];
      });
    } catch (e) {
      debugPrint('Error loading chats: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _showChatActionsDialog(AdminChatModel chat) async {
    final ownerController = TextEditingController(text: chat.ownerName);

    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(chat.name),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${chat.isGroup ? 'Группа' : 'Личный чат'} • ${chat.membersCount} участников',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: ownerController,
                decoration: const InputDecoration(
                  labelText: 'Владелец',
                  hintText: 'Email или имя нового владельца',
                ),
              ),
              const SizedBox(height: 16),
              if (!chat.isArchived) ...[
                OutlinedButton.icon(
                  onPressed: () async {
                    // TODO: await client.admin.archiveChat(chatId: chat.id);
                    Navigator.of(ctx).pop();
                    _loadChats();
                  },
                  icon: const Icon(Icons.archive_outlined),
                  label: const Text('Архивировать'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 44),
                  ),
                ),
              ] else ...[
                FilledButton.icon(
                  onPressed: () async {
                    final confirmed = await _confirmDelete(ctx, chat.name);
                    if (confirmed == true && ctx.mounted) {
                      // TODO: await client.admin.deleteChat(chatId: chat.id);
                      Navigator.of(ctx).pop();
                      _loadChats();
                    }
                  },
                  icon: const Icon(Icons.delete_outlined),
                  label: const Text('Удалить навсегда'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                    minimumSize: const Size(double.infinity, 44),
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Закрыть'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
            onPressed: () async {
              // TODO: await client.admin.updateChatOwner(
              //   chatId: chat.id,
              //   ownerName: ownerController.text,
              // );
              Navigator.of(ctx).pop();
              _loadChats();
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );

    ownerController.dispose();
  }

  Future<bool?> _confirmDelete(BuildContext ctx, String chatName) {
    return showDialog<bool>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text('Удалить чат?'),
        content: Text('Чат "$chatName" и все его сообщения будут удалены безвозвратно.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отмена'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              minimumSize: const Size(0, 44),
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Удалить'),
          ),
        ],
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
          : ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (_, i) {
                final chat = _chats[i];
                return ListTile(
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: chat.isArchived
                          ? colorScheme.surfaceContainerHighest
                          : chat.isGroup
                              ? colorScheme.secondaryContainer
                              : colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      chat.isArchived
                          ? Icons.archive_outlined
                          : chat.isGroup
                              ? Icons.group
                              : Icons.person,
                      color: chat.isArchived
                          ? colorScheme.onSurfaceVariant
                          : chat.isGroup
                              ? colorScheme.onSecondaryContainer
                              : colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: Text(
                    chat.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: chat.isArchived
                          ? colorScheme.onSurfaceVariant
                          : null,
                    ),
                  ),
                  subtitle: Text(
                    'Владелец: ${chat.ownerName} • ${chat.membersCount} уч.',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (chat.isArchived)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Архив',
                            style: TextStyle(
                              fontSize: 11,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      const SizedBox(width: 4),
                      Icon(Icons.chevron_right,
                          color: colorScheme.outlineVariant),
                    ],
                  ),
                  onTap: () => _showChatActionsDialog(chat),
                );
              },
            ),
    );
  }
}
