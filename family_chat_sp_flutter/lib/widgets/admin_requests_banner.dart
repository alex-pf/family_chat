import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

/// Polls [client.auth.getPendingRequests] every 15 seconds and renders a
/// card per pending email with an "Issue access" button.
class AdminRequestsBanner extends StatefulWidget {
  const AdminRequestsBanner({super.key});

  @override
  State<AdminRequestsBanner> createState() => _AdminRequestsBannerState();
}

class _AdminRequestsBannerState extends State<AdminRequestsBanner> {
  List<String> _emails = [];
  Timer? _timer;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _poll();
    _timer = Timer.periodic(const Duration(seconds: 15), (_) => _poll());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _poll() async {
    if (_loading) return;
    _loading = true;
    try {
      final emails = await client.auth.getPendingRequests();
      if (mounted) setState(() => _emails = emails);
    } catch (_) {
      // Silently ignore polling errors.
    } finally {
      _loading = false;
    }
  }

  Future<void> _issueToken(String email) async {
    try {
      final token = await client.auth.issueAccessToken(email);
      if (!mounted) return;

      setState(() => _emails.remove(email));

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Токен выдан'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Токен доступа для $email:'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SelectableText(
                  token,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: token));
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Скопировано')),
                );
              },
              child: const Text('Копировать'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_emails.isEmpty) return const SizedBox.shrink();

    final cs = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: _emails.map((email) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          color: cs.tertiaryContainer,
          child: ListTile(
            leading: Icon(Icons.vpn_key, color: cs.onTertiaryContainer),
            title: Text(
              'Запрос доступа: $email',
              style: TextStyle(
                fontSize: 14,
                color: cs.onTertiaryContainer,
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () => _issueToken(email),
              style: ElevatedButton.styleFrom(
                backgroundColor: cs.primary,
                foregroundColor: cs.onPrimary,
              ),
              child: const Text('Выдать доступ'),
            ),
          ),
        );
      }).toList(),
    );
  }
}
