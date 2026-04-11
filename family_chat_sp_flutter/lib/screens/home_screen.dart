import 'dart:async';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_core_flutter/serverpod_auth_core_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;


import '../main.dart';
import '../app_state.dart';
import '../widgets/chat_list_tile.dart';
import '../widgets/user_avatar.dart';
import 'login_screen.dart';
import 'chat_screen.dart';
import 'admin/admin_screen.dart';
import 'my_profile_screen.dart';

/// Простая модель данных чата для UI
class ChatPreview {
  final int id;
  final String name;
  final bool isGroup;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final bool isBlocked;

  const ChatPreview({
    required this.id,
    required this.name,
    required this.isGroup,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
    this.isBlocked = false,
  });
}

enum ChatFilter { all, direct, group }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatPreview> _chats = [];
  bool _isLoading = true;
  ChatFilter _filter = ChatFilter.all;
  StreamSubscription<dynamic>? _chatStreamSub;

  @override
  void initState() {
    super.initState();
    timeago.setLocaleMessages('ru', timeago.RuMessages());
    _loadChats();
    _subscribeToStream();
  }

  @override
  void dispose() {
    _chatStreamSub?.cancel();
    super.dispose();
  }

  Future<void> _loadChats() async {
    setState(() => _isLoading = true);
    try {
      // TODO: после serverpod generate:
      // final chats = await client.chat.getChatList();
      // setState(() {
      //   _chats = chats.map((c) => ChatPreview(
      //     id: c.id!,
      //     name: c.name,
      //     isGroup: c.isGroup,
      //     lastMessage: c.lastMessage?.text,
      //     lastMessageAt: c.lastMessage?.sentAt,
      //     unreadCount: c.unreadCount,
      //     isBlocked: c.isBlocked,
      //   )).toList();
      // });

      // Заглушка
      setState(() {
        _chats = [
          ChatPreview(
            id: 1,
            name: 'Мама',
            isGroup: false,
            lastMessage: 'Ужин готов!',
            lastMessageAt: DateTime.now().subtract(const Duration(minutes: 5)),
            unreadCount: 2,
          ),
          ChatPreview(
            id: 2,
            name: 'Вся семья',
            isGroup: true,
            lastMessage: 'Папа: Едем на дачу в воскресенье',
            lastMessageAt: DateTime.now().subtract(const Duration(hours: 1)),
            unreadCount: 0,
          ),
          ChatPreview(
            id: 3,
            name: 'Папа',
            isGroup: false,
            lastMessage: 'Буду дома в 7',
            lastMessageAt: DateTime.now().subtract(const Duration(hours: 3)),
            unreadCount: 0,
          ),
        ];
      });
    } catch (e) {
      debugPrint('Error loading chats: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _subscribeToStream() {
    // TODO: после serverpod generate:
    // _chatStreamSub = client.chat.chatListStream().listen((update) {
    //   setState(() {
    //     final idx = _chats.indexWhere((c) => c.id == update.chatId);
    //     if (idx >= 0) {
    //       _chats[idx] = _chats[idx].copyWith(
    //         lastMessage: update.lastMessage,
    //         lastMessageAt: update.lastMessageAt,
    //         unreadCount: update.unreadCount,
    //       );
    //     }
    //   });
    // });
  }

  List<ChatPreview> get _filteredChats {
    switch (_filter) {
      case ChatFilter.all:
        return _chats;
      case ChatFilter.direct:
        return _chats.where((c) => !c.isGroup).toList();
      case ChatFilter.group:
        return _chats.where((c) => c.isGroup).toList();
    }
  }

  Future<void> _showCreateChatDialog() async {
    final nameController = TextEditingController();
    bool isGroup = false;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Создать чат'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Название',
                  hintText: 'Например: Семья',
                ),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Групповой чат'),
                value: isGroup,
                onChanged: (v) => setDialogState(() => isGroup = v),
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Отмена'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
              onPressed: () async {
                final name = nameController.text.trim();
                if (name.isEmpty) return;

                // TODO: await client.chat.createChat(name: name, isGroup: isGroup);
                Navigator.of(ctx).pop();
                _loadChats();
              },
              child: const Text('Создать'),
            ),
          ],
        ),
      ),
    );

    nameController.dispose();
  }

  Future<void> _signOut() async {
    try {
      await client.authSessionManager.signOutDevice();
    } catch (_) {}
    appState.clear();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        final user = appState.currentUser;

        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            title: const Text('FamilyChat'),
            actions: [
              // User avatar menu
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: PopupMenuButton<String>(
                  offset: const Offset(0, 48),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: user != null
                        ? UserAvatar(name: user.name, size: 36)
                        : const CircleAvatar(
                            radius: 18,
                            child: Icon(Icons.person),
                          ),
                  ),
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'profile',
                      child: Row(
                        children: [
                          const Icon(Icons.person_outlined),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(user?.name ?? 'Профиль'),
                              if (user?.email != null)
                                Text(
                                  user!.email,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (appState.isAdmin)
                      const PopupMenuItem(
                        value: 'admin',
                        child: Row(
                          children: [
                            Icon(Icons.admin_panel_settings_outlined),
                            SizedBox(width: 12),
                            Text('Администрирование'),
                          ],
                        ),
                      ),
                    const PopupMenuDivider(),
                    const PopupMenuItem(
                      value: 'logout',
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(width: 12),
                          Text('Выйти'),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'logout') _signOut();
                    if (value == 'profile') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const MyProfileScreen()),
                      );
                    }
                    if (value == 'admin') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => const AdminScreen()),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              // Filter chips
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: SegmentedButton<ChatFilter>(
                  showSelectedIcon: false,
                  segments: const [
                    ButtonSegment(value: ChatFilter.all, label: Text('Все')),
                    ButtonSegment(
                        value: ChatFilter.direct, label: Text('1-1')),
                    ButtonSegment(
                        value: ChatFilter.group, label: Text('Группы')),
                  ],
                  selected: {_filter},
                  onSelectionChanged: (s) =>
                      setState(() => _filter = s.first),
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(
                        const Size(0, 40)),
                  ),
                ),
              ),

              // Chat list
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _filteredChats.isEmpty
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
                                  style: TextStyle(
                                    color: colorScheme.onSurfaceVariant,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: _loadChats,
                            child: ListView.separated(
                              itemCount: _filteredChats.length,
                              separatorBuilder: (context, index) => Divider(
                                height: 1,
                                indent: 80,
                                color: colorScheme.outlineVariant
                                    .withAlpha(80),
                              ),
                              itemBuilder: (_, i) {
                                final chat = _filteredChats[i];
                                return ChatListTile(
                                  chatId: chat.id,
                                  chatName: chat.name,
                                  isGroup: chat.isGroup,
                                  lastMessage: chat.lastMessage,
                                  lastMessageAt: chat.lastMessageAt,
                                  unreadCount: chat.unreadCount,
                                  isBlocked: chat.isBlocked,
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ChatScreen(
                                        chatId: chat.id,
                                        chatName: chat.name,
                                        isGroup: chat.isGroup,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),

          // FAB — только для master/admin
          floatingActionButton:
              (appState.isMaster || appState.isAdmin)
                  ? FloatingActionButton(
                      onPressed: _showCreateChatDialog,
                      child: const Icon(Icons.edit_outlined),
                    )
                  : null,
        );
      },
    );
  }
}
