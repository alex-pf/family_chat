import 'package:flutter/material.dart';

/// Цветной квадрат (скруглённый) с инициалами пользователя.
/// Если [isBlocked] = true, поверх накладывается серая полупрозрачная маска.
class UserAvatar extends StatelessWidget {
  final String name;
  final int? userId;
  final String? avatarUrl;
  final bool isBlocked;
  final double size;

  const UserAvatar({
    super.key,
    required this.name,
    this.userId,
    this.avatarUrl,
    this.isBlocked = false,
    this.size = 44,
  });

  String get _initials {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  Color _colorForName(String name) {
    const colors = [
      Color(0xFF7C4DFF),
      Color(0xFF00BCD4),
      Color(0xFF4CAF50),
      Color(0xFFFF7043),
      Color(0xFFE91E63),
      Color(0xFF2196F3),
      Color(0xFFFF9800),
      Color(0xFF009688),
    ];
    int hash = 0;
    for (final c in name.codeUnits) {
      hash = (hash * 31 + c) & 0xFFFFFF;
    }
    return colors[hash % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _colorForName(name);
    final radius = BorderRadius.circular(size * 0.25);

    Widget avatar;

    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      avatar = ClipRRect(
        borderRadius: radius,
        child: Image.network(
          avatarUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _buildInitialsBox(bgColor, radius),
        ),
      );
    } else {
      avatar = _buildInitialsBox(bgColor, radius);
    }

    if (isBlocked) {
      return Stack(
        children: [
          avatar,
          ClipRRect(
            borderRadius: radius,
            child: Container(
              width: size,
              height: size,
              color: Colors.grey.withAlpha(160),
              child: Icon(
                Icons.block,
                size: size * 0.4,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      );
    }

    return avatar;
  }

  Widget _buildInitialsBox(Color bgColor, BorderRadius radius) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: radius,
      ),
      child: Center(
        child: Text(
          _initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.38,
            fontWeight: FontWeight.w700,
            height: 1,
          ),
        ),
      ),
    );
  }
}
