import 'package:flutter/material.dart';

/// Экран управления ресурсами (хранилище файлов) для Admin
class AdminResourcesScreen extends StatefulWidget {
  const AdminResourcesScreen({super.key});

  @override
  State<AdminResourcesScreen> createState() => _AdminResourcesScreenState();
}

class _AdminResourcesScreenState extends State<AdminResourcesScreen> {
  bool _isLoading = true;

  // Данные хранилища
  int _usedBytes = 0;
  int _limitBytes = 5 * 1024 * 1024 * 1024; // 5 GB default
  int _maxFileSizeMb = 50;
  int _deleteOlderThanDays = 90;
  int? _previewDeleteBytes; // сколько освободится
  bool _isCalculating = false;
  bool _isDeleting = false;

  final _maxFileSizeController = TextEditingController();
  final _deleteOlderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  @override
  void dispose() {
    _maxFileSizeController.dispose();
    _deleteOlderController.dispose();
    super.dispose();
  }

  Future<void> _loadStats() async {
    setState(() => _isLoading = true);
    try {
      // TODO: после serverpod generate:
      // final stats = await client.admin.getStorageStats();
      // setState(() {
      //   _usedBytes = stats.usedBytes;
      //   _limitBytes = stats.limitBytes;
      //   _maxFileSizeMb = stats.maxFileSizeMb;
      // });

      // Заглушка
      setState(() {
        _usedBytes = 2_340_000_000; // 2.34 GB
        _limitBytes = 5_000_000_000; // 5 GB
        _maxFileSizeMb = 50;
        _maxFileSizeController.text = _maxFileSizeMb.toString();
        _deleteOlderController.text = _deleteOlderThanDays.toString();
      });
    } catch (e) {
      debugPrint('Error loading storage stats: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _calculateDeletePreview() async {
    final days = int.tryParse(_deleteOlderController.text);
    if (days == null || days <= 0) return;

    setState(() => _isCalculating = true);
    try {
      // TODO: await client.admin.previewDeleteOldFiles(olderThanDays: days)
      //   → returns freed bytes

      // Заглушка — имитация
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _previewDeleteBytes = (days < 30)
            ? 500_000_000
            : (days < 60)
                ? 200_000_000
                : 80_000_000;
        _deleteOlderThanDays = days;
      });
    } finally {
      if (mounted) setState(() => _isCalculating = false);
    }
  }

  Future<void> _confirmAndDeleteOldFiles() async {
    if (_previewDeleteBytes == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Удалить старые файлы?'),
        content: Text(
          'Файлы старше $_deleteOlderThanDays дней будут удалены. '
          'Освободится ${_formatBytes(_previewDeleteBytes!)}. '
          'Это действие необратимо.',
        ),
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

    if (confirmed != true || !mounted) return;

    setState(() => _isDeleting = true);
    try {
      // TODO: await client.admin.deleteOldFiles(olderThanDays: _deleteOlderThanDays);
      await Future.delayed(const Duration(milliseconds: 800)); // имитация
      setState(() {
        _usedBytes = (_usedBytes - _previewDeleteBytes!).clamp(0, _limitBytes);
        _previewDeleteBytes = null;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Файлы удалены')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isDeleting = false);
    }
  }

  Future<void> _saveFileSizeLimit() async {
    final mb = int.tryParse(_maxFileSizeController.text);
    if (mb == null || mb <= 0) return;

    try {
      // TODO: await client.admin.setMaxFileSize(maxMb: mb);
      setState(() => _maxFileSizeMb = mb);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Лимит файла обновлён')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    }
  }

  String _formatBytes(int bytes) {
    if (bytes >= 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} ГБ';
    } else if (bytes >= 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} МБ';
    } else if (bytes >= 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} КБ';
    }
    return '$bytes Б';
  }

  double get _usageRatio =>
      _limitBytes > 0 ? (_usedBytes / _limitBytes).clamp(0.0, 1.0) : 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Ресурсы')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Storage usage card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.storage_outlined,
                                  color: colorScheme.primary),
                              const SizedBox(width: 8),
                              Text(
                                'Использование хранилища',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          LinearProgressIndicator(
                            value: _usageRatio,
                            backgroundColor: colorScheme.surfaceContainerHighest,
                            color: _usageRatio > 0.9
                                ? colorScheme.error
                                : _usageRatio > 0.7
                                    ? Colors.orange
                                    : colorScheme.primary,
                            minHeight: 10,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatBytes(_usedBytes),
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'из ${_formatBytes(_limitBytes)}',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Max file size settings
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.insert_drive_file_outlined,
                                  color: colorScheme.primary),
                              const SizedBox(width: 8),
                              Text(
                                'Максимальный размер файла',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _maxFileSizeController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Лимит (МБ)',
                                    suffixText: 'МБ',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              FilledButton(
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size(80, 52),
                                ),
                                onPressed: _saveFileSizeLimit,
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Текущий лимит: $_maxFileSizeMb МБ',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Delete old files
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.delete_sweep_outlined,
                                  color: colorScheme.error),
                              const SizedBox(width: 8),
                              Text(
                                'Очистка старых файлов',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _deleteOlderController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: 'Старше N дней',
                                    suffixText: 'дн.',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size(100, 52),
                                ),
                                onPressed: _isCalculating
                                    ? null
                                    : _calculateDeletePreview,
                                child: _isCalculating
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2),
                                      )
                                    : const Text('Preview'),
                              ),
                            ],
                          ),

                          // Preview result
                          if (_previewDeleteBytes != null) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: colorScheme.errorContainer,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.info_outline,
                                      color: colorScheme.onErrorContainer,
                                      size: 18),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'Будет освобождено: ${_formatBytes(_previewDeleteBytes!)}',
                                      style: TextStyle(
                                        color: colorScheme.onErrorContainer,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            FilledButton.icon(
                              onPressed: _isDeleting
                                  ? null
                                  : _confirmAndDeleteOldFiles,
                              icon: _isDeleting
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.delete_forever),
                              label: const Text('Удалить'),
                              style: FilledButton.styleFrom(
                                backgroundColor: colorScheme.error,
                                foregroundColor: colorScheme.onError,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
