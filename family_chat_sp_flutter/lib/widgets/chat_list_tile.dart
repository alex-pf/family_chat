import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'user_avatar.dart';

/// Плитка чата в списке HomeScreen
class ChatListTile extends StatelessWidget {
  final int chatId;
  final String chatName;
  final bool isGroup;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final bool isBlocked;
  final VoidCallback onTap;

  const ChatListTile({
    super.key,
    required this.chatId,
    required this.chatName,
    required this.isGroup,
    this.lastMessage,
    this.lastMessageAt,
    this.unreadCount = 0,
    this.isBlocked = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Widget avatar;
    if (isGroup) {
      avatar = Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(
          Icons.group,
          color: colorScheme.onSecondaryContainer,
          size: 28,
        ),
      );
    } else {
      avatar = UserAvatar(
        name: chatName,
        size: 52,
        isBlocked: isBlocked,
      );
    }

    return Opacity(
      opacity: isBlocked ? 0.55 : 1.0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: avatar,
        title: Text(
          chatName,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: lastMessage != null
            ? Text(
                lastMessage!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (lastMessageAt != null) ...[
              Text(
                timeago.format(lastMessageAt!, locale: 'ru'),
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
            ],
            if (unreadCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  unreadCount > 99 ? '99+' : '$unreadCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
