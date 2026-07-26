
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../../injection/dependency_injection.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _urlController = TextEditingController();
  final ApiClient _apiClient = sl<ApiClient>();

  @override
  void initState() {
    super.initState();
    _urlController.text = _apiClient.currentBaseUrl;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Application Settings')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('Engine Infrastructure Configuration', style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          TextField(
            controller: _urlController,
            decoration: InputDecoration(
              labelText: 'FastAPI Backend Core URL',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              suffixIcon: IconButton(
                icon: const Icon(Icons.save_rounded),
                onPressed: () {
                  _apiClient.updateBaseUrl(_urlController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('API Gateway environment parameters updated locally.')),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text('Preferences', style: theme.textTheme.titleMedium),
          SwitchListTile(
            title: const Text('Dynamic Dark System Theme Match'),
            value: true,
            onChanged: (_) {},
            contentPadding: EdgeInsets.zero,
          ),
          SwitchListTile(
            title: const Text('Immediate Push Warnings'),
            value: false,
            onChanged: (_) {},
            contentPadding: EdgeInsets.zero,
          ),
          const Divider(height: 40),
          ListTile(
            title: const Text('Privacy Compliance Documentation'),
            trailing: const Icon(Icons.chevron_right_rounded),
            contentPadding: EdgeInsets.zero,
            onTap: () {},
          ),
          ListTile(
            title: const Text('Terms of Use Policy'),
            trailing: const Icon(Icons.chevron_right_rounded),
            contentPadding: EdgeInsets.zero,
            onTap: () {},
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'App Stable Build Pipeline: Version ${AppConstants.appVersion}',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.disabledColor),
            ),
          ),
        ],
      ),
    );
  }
}