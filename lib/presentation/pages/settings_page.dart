import 'package:flutter/material.dart';
import 'package:selous/core/constants/app_constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _displayName = 'Anonymous';
  bool _autoStart = false;
  bool _encryptByDefault = true;
  bool _darkMode = false;
  String _logLevel = 'INFO';
  
  final List<String> _logLevels = ['DEBUG', 'INFO', 'WARNING', 'ERROR'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Profile'),
          ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: const Text('Display Name'),
            subtitle: Text(_displayName),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _editDisplayName(),
          ),
          
          _buildSectionHeader('Network'),
          SwitchListTile(
            secondary: const Icon(Icons.wifi_tethering),
            title: const Text('Auto-start Network'),
            subtitle: const Text('Automatically start when app opens'),
            value: _autoStart,
            onChanged: (value) => setState(() => _autoStart = value),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.security),
            title: const Text('Encryption by Default'),
            subtitle: const Text('Encrypt all messages automatically'),
            value: _encryptByDefault,
            onChanged: (value) => setState(() => _encryptByDefault = value),
          ),
          
          _buildSectionHeader('Appearance'),
          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            value: _darkMode,
            onChanged: (value) => setState(() => _darkMode = value),
          ),
          
          _buildSectionHeader('Advanced'),
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: const Text('Log Level'),
            trailing: DropdownButton<String>(
              value: _logLevel,
              underline: const SizedBox(),
              items: _logLevels.map((level) => DropdownMenuItem(
                value: level,
                child: Text(level),
              )).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _logLevel = value);
                }
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text(
              'Clear All Data',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => _confirmClearData(),
          ),
          
          _buildSectionHeader('About'),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Version'),
            trailing: Text(AppConstants.appVersion),
          ),
          const ListTile(
            leading: Icon(Icons.code),
            title: Text('Open Source'),
            subtitle: Text('SELous is built with Flutter'),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppConstants.primaryColor,
        ),
      ),
    );
  }

  void _editDisplayName() {
    final controller = TextEditingController(text: _displayName);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Display Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Name',
            hintText: 'Enter your display name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _displayName = controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _confirmClearData() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This will delete all messages, device history, and settings. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Clear data logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data cleared')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
