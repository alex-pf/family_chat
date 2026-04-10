import 'dart:async';
import 'package:flutter/material.dart';

import '../app_state.dart';
import '../widgets/message_bubble.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/user_profile_modal.dart';

/// Простая модель сообщения для UI
class ChatMessage {
  final int id;
  final int senderId;
  final String senderName;
  final String? senderAvatarUrl;
  final String text;
  final DateTime sentAt;
  final bool isDeleted;
  final bool isEdited;
  final MessageStatus status;
  final List<MessageReaction> reactions;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.senderName,
    this.senderAvatarUrl,
    required this.text,
    required this.sentAt,
    this.isDeleted = false,
    this.isEdited = false,
    this.status = MessageStatus.sent,
    this.reactions = const [],
  });
}

/// Предустановленные фоны чата
const List<Color> kChatBackgrounds = [
  Color(0xFFF3E5F5), // Сиреневый
  Color(0xFFE8F5E9), // Зелёный
  Color(0xFFFFF3E0), // Оранжевый
  Color(0xFFE3F2FD), // Синий
  Color(0xFFFCE4EC), // Розовый
  Color(0xFFF9FBE7), // Жёлтый
];

class ChatScreen extends StatefulWidget {
  final int chatId;
  final String chatName;
  final bool isGroup;

  const ChatScreen({
    super.key,
    required this.chatId,
    required this.chatName,
    required this.isGroup,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  bool _isSending = false;
  // ignore: prefer_final_fields — will be mutated by typing stream TODO
  bool _isTyping = false; // someone else is typing
  String? _typingUserName;
  StreamSubscription<dynamic>? _messageStreamSub;
  StreamSubscription<dynamic>? _typingStreamSub;
  Timer? _typingDebounce;
  Color _bgColor = kChatBackgrounds[0];

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _subscribeToStream();
    _inputController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _messageStreamSub?.cancel();
    _typingStreamSub?.cancel();
    _typingDebounce?.cancel();
    _inputController.removeListener(_onInputChanged);
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadMessages() async {
    setState(() => _isLoading = true);
    try {
      // TODO: после serverpod generate:
      // final msgs = await client.chat.getMessages(chatId: widget.chatId);
      // setState(() {
      //   _messages.addAll(msgs.map(...));
      // });

      // Заглушка
      setState(() {
        _messages.addAll([
          ChatMessage(
            id: 1,
            senderId: 2,
            senderName: 'Мама',
            text: 'Привет! Как дела?',
            sentAt: DateTime.now().subtract(const Duration(minutes: 30)),
            status: MessageStatus.read,
          ),
          ChatMessage(
            id: 2,
            senderId: appState.currentUser?.id ?? 1,
            senderName: appState.currentUser?.name ?? 'Я',
            text: 'Всё отлично! Скоро приеду.',
            sentAt: DateTime.now().subtract(const Duration(minutes: 25)),
            status: MessageStatus.read,
          ),
          ChatMessage(
            id: 3,
            senderId: 2,
            senderName: 'Мама',
            text: 'Ужин готов!',
            sentAt: DateTime.now().subtract(const Duration(minutes: 5)),
            status: MessageStatus.delivered,
            reactions: [
              MessageReaction(emoji: '❤️', count: 1, myReaction: true),
            ],
          ),
        ]);
      });
    } catch (e) {
      debugPrint('Error loading messages: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _subscribeToStream() {
    // TODO: после serverpod generate:
    // _messageStreamSub = client.chat.messageStream(widget.chatId).listen((msg) {
    //   setState(() {
    //     _messages.insert(0, ChatMessage(...));
    //   });
    //   _scrollToBottom();
    // });
    //
    // _typingStreamSub = client.chat.typingStream(widget.chatId).listen((event) {
    //   setState(() {
    //     _isTyping = event.isTyping;
    //     _typingUserName = event.userName;
    //   });
    // });
  }

  void _onInputChanged() {
    // Отправить typing indicator
    _typingDebounce?.cancel();
    if (_inputController.text.isNotEmpty) {
      // TODO: client.chat.sendTyping(chatId: widget.chatId);
      _typingDebounce = Timer(const Duration(seconds: 3), () {
        // TODO: client.chat.stopTyping(chatId: widget.chatId);
      });
    }
    setState(() {}); // Update send button visibility
  }

  Future<void> _sendMessage() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _isSending) return;

    _inputController.clear();
    setState(() => _isSending = true);

    try {
      // TODO: после serverpod generate:
      // await client.chat.sendMessage(chatId: widget.chatId, text: text);

      // Оптимистичное добавление сообщения
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            id: DateTime.now().millisecondsSinceEpoch,
            senderId: appState.currentUser?.id ?? 0,
            senderName: appState.currentUser?.name ?? 'Я',
            text: text,
            sentAt: DateTime.now(),
            status: MessageStatus.sent,
          ),
        );
      });
      _scrollToBottom();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка отправки: $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      // Вернуть текст в поле
      _inputController.text = text;
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _showMessageMenu(ChatMessage msg, bool isOwn) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            // Reactions row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: ['❤️', '😂', '👍', '😢', '😮', '🔥']
                    .map(
                      (e) => GestureDetector(
                        onTap: () => Navigator.of(context).pop('react_$e'),
                        child: Text(e,
                            style: const TextStyle(fontSize: 28)),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Divider(),
            if (isOwn && !msg.isDeleted) ...[
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Редактировать'),
                onTap: () => Navigator.of(context).pop('edit'),
              ),
              ListTile(
                leading: Icon(Icons.delete_outlined,
                    color: Theme.of(context).colorScheme.error),
                title: Text(
                  'Удалить',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.error),
                ),
                onTap: () => Navigator.of(context).pop('delete'),
              ),
            ],
            const SizedBox(height: 8),
          ],
        ),
      ),
    );

    if (result == null || !mounted) return;

    if (result.startsWith('react_')) {
      final emoji = result.substring(6);
      // TODO: await client.chat.addReaction(messageId: msg.id, emoji: emoji);
      debugPrint('React $emoji to message ${msg.id}');
    } else if (result == 'edit') {
      _showEditDialog(msg);
    } else if (result == 'delete') {
      _confirmDelete(msg);
    }
  }

  Future<void> _showEditDialog(ChatMessage msg) async {
    final controller = TextEditingController(text: msg.text);
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Редактировать'),
        content: TextField(
          controller: controller,
          maxLines: null,
          decoration: const InputDecoration(hintText: 'Текст сообщения'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Отмена'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 44)),
            onPressed: () {
              final newText = controller.text.trim();
              if (newText.isEmpty) return;
              // TODO: await client.chat.editMessage(messageId: msg.id, text: newText);
              Navigator.of(ctx).pop();
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
    controller.dispose();
  }

  Future<void> _confirmDelete(ChatMessage msg) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Удалить сообщение?'),
        content: const Text('Сообщение будет удалено для всех участников.'),
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

    if (confirmed == true) {
      // TODO: await client.chat.deleteMessage(messageId: msg.id);
    }
  }

  void _showBackgroundPicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Фон чата',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: kChatBackgrounds.map((color) {
                  final isSelected = color == _bgColor;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _bgColor = color);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .outlineVariant,
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: isSelected
                          ? Icon(
                              Icons.check,
                              color:
                                  Theme.of(context).colorScheme.primary,
                            )
                          : null,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAndSendMedia() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_outlined),
              title: const Text('Фото из галереи'),
              onTap: () => Navigator.of(context).pop('image'),
            ),
            ListTile(
              leading: const Icon(Icons.attach_file_outlined),
              title: const Text('Файл'),
              onTap: () => Navigator.of(context).pop('file'),
            ),
          ],
        ),
      ),
    );

    if (result == null) return;
    // TODO: image_picker / file_picker + upload + send
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final myUserId = appState.currentUser?.id ?? -1;

    return Scaffold(
      backgroundColor: _bgColor,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        titleSpacing: 0,
        title: Row(
          children: [
            // Avatar / group icon — tap → UserProfileModal
            GestureDetector(
              onTap: widget.isGroup
                  ? null
                  : () => UserProfileModal.show(
                        context,
                        userId: widget.chatId,
                        name: widget.chatName,
                      ),
              child: widget.isGroup
                  ? Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.group,
                          color: colorScheme.onSecondaryContainer,
                          size: 20),
                    )
                  : Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          widget.chatName.isNotEmpty
                              ? widget.chatName[0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.chatName,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.format_paint_outlined),
            onPressed: _showBackgroundPicker,
            tooltip: 'Фон чата',
          ),
          if (appState.isAdmin || appState.isMaster)
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                // TODO: ChatSettingsScreen
              },
              tooltip: 'Настройки чата',
            ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _messages.length + (_isTyping ? 1 : 0),
                    itemBuilder: (_, index) {
                      // Typing indicator at top (index 0 when reversed)
                      if (_isTyping && index == 0) {
                        return TypingIndicator(userName: _typingUserName);
                      }

                      final msgIndex = _isTyping ? index - 1 : index;
                      final msg = _messages[msgIndex];
                      final isOwn = msg.senderId == myUserId;

                      return MessageBubble(
                        messageId: msg.id,
                        text: msg.text,
                        senderName: msg.senderName,
                        senderAvatarUrl: msg.senderAvatarUrl,
                        isOwn: isOwn,
                        sentAt: msg.sentAt,
                        isDeleted: msg.isDeleted,
                        isEdited: msg.isEdited,
                        status: msg.status,
                        reactions: msg.reactions,
                        onTap: () => _showMessageMenu(msg, isOwn),
                        onLongPress: () => _showMessageMenu(msg, isOwn),
                      );
                    },
                  ),
          ),

          // Input bar
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border(
                top: BorderSide(
                    color: colorScheme.outlineVariant, width: 0.5),
              ),
            ),
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
              top: 8,
              bottom: 8 + MediaQuery.of(context).padding.bottom,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Attach button
                IconButton(
                  icon: const Icon(Icons.attach_file_outlined),
                  onPressed: _pickAndSendMedia,
                  color: colorScheme.onSurfaceVariant,
                ),

                // Text input
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    maxLines: null,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: 'Сообщение...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest
                          .withAlpha(120),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                  ),
                ),

                // Send button — visible only when text is not empty
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: _inputController.text.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: FloatingActionButton.small(
                            heroTag: 'send_fab',
                            onPressed: _isSending ? null : _sendMessage,
                            elevation: 0,
                            child: _isSending
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.send),
                          ),
                        )
                      : const SizedBox(width: 4, key: ValueKey('empty')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
