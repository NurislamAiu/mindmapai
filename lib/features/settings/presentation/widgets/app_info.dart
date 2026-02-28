import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({super.key});

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  String _version = '...';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          _version = packageInfo.version;
        });
      }
    } catch (e) {
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Center(
        child: Column(
          children: [
            Text('MINDRA v$_version',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey.shade500, fontWeight: FontWeight.w300)),
            const SizedBox(height: 4),
            Text('© 2026 MINDRA. All rights reserved.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.grey.shade400, fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}
