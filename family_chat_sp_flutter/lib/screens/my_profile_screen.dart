import 'package:flutter/material.dart';

import '../main.dart';
import '../app_state.dart'; // AppUser, UserRole, appState

/// Экран профиля текущего пользователя.
/// Открывается из меню в правом верхнем углу.
class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  bool _isSaving = false;
  String? _errorMessage;
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: appState.currentUser?.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isSaving = true;
      _errorMessage = null;
      _saved = false;
    });
    try {
      final updated =
          await client.user.updateProfile(_nameController.text.trim());
      // Обновляем глобальное состояние через публичный метод
      appState.updateCurrentUserName(updated.name);
      if (mounted) setState(() => _saved = true);
    } catch (e) {
      if (mounted) setState(() => _errorMessage = e.toString());
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final user = appState.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой профиль'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              // ── Аватар ──────────────────────────────────────────────
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(
                      user?.initials ?? '?',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  // Кнопка смены аватара (пока UI-заглушка — загрузка
                  // изображений будет добавлена при подключении S3/CDN)
                  Tooltip(
                    message: 'Загрузка аватара будет доступна в следующей версии',
                    child: Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          size: 18,
                          color: colorScheme.onPrimary,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Загрузка аватара будет доступна в следующей версии',
                              ),
                            ),
                          );
                        },
                        padding: const EdgeInsets.all(6),
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Email (read-only)
              Text(
                user?.email ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),

              const SizedBox(height: 32),

              // ── Форма ────────────────────────────────────────────────
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Имя',
                  hintText: 'Как вас называть',
                  prefixIcon: Icon(Icons.person_outlined),
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Имя не может быть пустым';
                  }
                  if (v.trim().length < 2) {
                    return 'Минимум 2 символа';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // ── Сохранить ────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 52),
                  ),
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Сохранить'),
                ),
              ),

              if (_saved) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline,
                        color: colorScheme.primary, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      'Сохранено',
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  ],
                ),
              ],

              if (_errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorMessage!,
                  style: TextStyle(color: colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ],

              const SizedBox(height: 32),

              // ── Роли ─────────────────────────────────────────────────
              if (appState.myRoles.isNotEmpty) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Мои роли',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: appState.myRoles.map((r) {
                      return Chip(
                        label: Text(_roleName(r)),
                        backgroundColor: colorScheme.secondaryContainer,
                        labelStyle:
                            TextStyle(color: colorScheme.onSecondaryContainer),
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _roleName(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return 'Администратор';
      case UserRole.master:
        return 'Мастер';
      case UserRole.family:
        return 'Семья';
      case UserRole.parents:
        return 'Родители';
      case UserRole.children:
        return 'Дети';
      case UserRole.guests:
        return 'Гости';
      case UserRole.friends:
        return 'Друзья';
    }
  }
}
