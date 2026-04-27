import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selous/core/constants/app_constants.dart';
import 'package:selous/presentation/bloc/app/app_bloc.dart';
import 'package:selous/presentation/pages/chat_page.dart';
import 'package:selous/presentation/pages/devices_page.dart';
import 'package:selous/presentation/pages/settings_page.dart';
import 'package:selous/presentation/widgets/network_status_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.appName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              AppConstants.appTagline,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isNetworkActive ? Icons.wifi_tethering : Icons.wifi_tethering_off,
                  color: state.isNetworkActive ? Colors.green : Colors.white70,
                ),
                onPressed: () {
                  context.read<AppBloc>().add(const NetworkToggleRequested());
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsPage()),
            ),
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.status == AppStatus.initializing) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Initializing SELous...'),
                ],
              ),
            );
          }
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NetworkStatusCard(),
                const SizedBox(height: 24),
                _buildQuickActions(context),
                const SizedBox(height: 24),
                _buildRecentActivity(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.security, color: AppConstants.primaryColor),
                ),
                const SizedBox(height: 12),
                const Text(
                  AppConstants.appName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'v${AppConstants.appVersion}',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            selected: true,
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Secure Chat'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.devices),
            title: const Text('Connected Devices'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DevicesPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ActionCard(
                icon: Icons.chat,
                title: 'Chat',
                color: AppConstants.primaryColor,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChatPage()),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ActionCard(
                icon: Icons.devices,
                title: 'Devices',
                color: AppConstants.secondaryColor,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DevicesPage()),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context, AppState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (state.connectedDevices.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.grey[400]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'No devices connected. Start the network to discover peers.',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ...state.connectedDevices.map((device) => Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppConstants.primaryColor.withOpacity(0.2),
                    child: const Icon(Icons.device_hub, color: AppConstants.primaryColor),
                  ),
                  title: Text(device.name),
                  subtitle: Text('Connected at ${device.connectedAt.toString().substring(11, 16)}'),
                  trailing: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: device.status.isConnected ? Colors.green : Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              )),
      ],
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppConstants.appName,
      applicationVersion: 'v${AppConstants.appVersion}',
      applicationIcon: const Icon(Icons.security, size: 48, color: AppConstants.primaryColor),
      children: const [
        Text(AppConstants.appTagline),
        SizedBox(height: 8),
        Text('Military-grade P2P mesh networking with end-to-end encryption.'),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
