import 'package:flutter/material.dart';
import 'user_avatar.dart';

/// Модальная карточка профиля пользователя.
/// Показывает аватар, имя, email и кнопку «Написать».
class UserProfileModal extends StatelessWidget {
  final int userId;
  final String name;
  final String? email;
  final String? avatarUrl;
  final bool isBlocked;
  final VoidCallback? onSendMessage;

  const UserProfileModal({
    super.key,
    required this.userId,
    required this.name,
    this.email,
    this.avatarUrl,
    this.isBlocked = false,
    this.onSendMessage,
  });

  static Future<void> show(
    BuildContext context, {
    required int userId,
    required String name,
    String? email,
    String? avatarUrl,
    bool isBlocked = false,
    VoidCallback? onSendMessage,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => UserProfileModal(
        userId: userId,
        name: name,
        email: email,
        avatarUrl: avatarUrl,
        isBlocked: isBlocked,
        onSendMessage: onSendMessage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            // Avatar
            UserAvatar(
              name: name,
              avatarUrl: avatarUrl,
              isBlocked: isBlocked,
              size: 80,
            ),
            const SizedBox(height: 16),

            // Name
            Text(
              name,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),

            if (email != null) ...[
              const SizedBox(height: 4),
              Text(
                email!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],

            if (isBlocked) ...[
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Заблокирован',
                  style: TextStyle(
                    color: colorScheme.onErrorContainer,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 28),

            // Write message button
            if (onSendMessage != null && !isBlocked)
              FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  onSendMessage!();
                },
                icon: const Icon(Icons.message_outlined),
                label: const Text('Написать'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(200, 52),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
