import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'user_avatar.dart';

/// Модель реакции
class MessageReaction {
  final String emoji;
  final int count;
  final bool myReaction;

  const MessageReaction({
    required this.emoji,
    required this.count,
    this.myReaction = false,
  });
}

/// Статус доставки сообщения
enum MessageStatus { sent, delivered, read }

/// Пузырь сообщения с поддержкой реакций, статусов, удалённых и отредактированных сообщений.
class MessageBubble extends StatelessWidget {
  final int messageId;
  final String text;
  final String senderName;
  final String? senderAvatarUrl;
  final bool isOwn;
  final DateTime sentAt;
  final bool isDeleted;
  final bool isEdited;
  final MessageStatus status;
  final List<MessageReaction> reactions;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const MessageBubble({
    super.key,
    required this.messageId,
    required this.text,
    required this.senderName,
    this.senderAvatarUrl,
    required this.isOwn,
    required this.sentAt,
    this.isDeleted = false,
    this.isEdited = false,
    this.status = MessageStatus.sent,
    this.reactions = const [],
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        left: isOwn ? 64 : 8,
        right: isOwn ? 8 : 64,
        top: 2,
        bottom: 2,
      ),
      child: Row(
        mainAxisAlignment:
            isOwn ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar for non-own messages
          if (!isOwn) ...[
            UserAvatar(
              name: senderName,
              avatarUrl: senderAvatarUrl,
              size: 32,
            ),
            const SizedBox(width: 6),
          ],

          Flexible(
            child: Column(
              crossAxisAlignment:
                  isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Sender name (for group chats)
                if (!isOwn) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                    child: Text(
                      senderName,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],

                // Message bubble
                GestureDetector(
                  onTap: onTap,
                  onLongPress: onLongPress,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isOwn
                          ? colorScheme.primary
                          : colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isOwn ? 16 : 4),
                        bottomRight: Radius.circular(isOwn ? 4 : 16),
                      ),
                      border: Border.all(
                        color: isOwn
                            ? colorScheme.primary.withAlpha(80)
                            : colorScheme.outlineVariant.withAlpha(60),
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Message text
                        if (isDeleted)
                          Text(
                            'сообщение удалено',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: isOwn
                                  ? colorScheme.onPrimary.withAlpha(160)
                                  : colorScheme.onSurfaceVariant,
                              fontSize: 14,
                            ),
                          )
                        else
                          Text(
                            text,
                            style: TextStyle(
                              color: isOwn
                                  ? colorScheme.onPrimary
                                  : colorScheme.onSurface,
                              fontSize: 15,
                            ),
                          ),

                        const SizedBox(height: 4),

                        // Time + edited + status
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isEdited && !isDeleted) ...[
                              Text(
                                'ред. ',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isOwn
                                      ? colorScheme.onPrimary.withAlpha(160)
                                      : colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                            Text(
                              DateFormat.Hm().format(sentAt),
                              style: TextStyle(
                                fontSize: 10,
                                color: isOwn
                                    ? colorScheme.onPrimary.withAlpha(160)
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                            if (isOwn) ...[
                              const SizedBox(width: 4),
                              _buildStatusIcon(colorScheme),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Reactions
                if (reactions.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 4,
                    children: reactions.map((r) {
                      return GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: r.myReaction
                                ? colorScheme.primaryContainer
                                : colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: r.myReaction
                                  ? colorScheme.primary.withAlpha(80)
                                  : colorScheme.outlineVariant,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(r.emoji,
                                  style: const TextStyle(fontSize: 13)),
                              const SizedBox(width: 3),
                              Text(
                                '${r.count}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: r.myReaction
                                      ? colorScheme.primary
                                      : colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(ColorScheme colorScheme) {
    switch (status) {
      case MessageStatus.sent:
        return Icon(Icons.check, size: 14,
            color: colorScheme.onPrimary.withAlpha(160));
      case MessageStatus.delivered:
        return Icon(Icons.done_all, size: 14,
            color: colorScheme.onPrimary.withAlpha(160));
      case MessageStatus.read:
        return Icon(Icons.done_all, size: 14,
            color: Colors.lightBlueAccent.shade100);
    }
  }
}
