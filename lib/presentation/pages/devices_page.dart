import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selous/core/constants/app_constants.dart';
import 'package:selous/presentation/bloc/app/app_bloc.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connected Devices'),
        backgroundColor: AppConstants.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh device list
            },
          ),
        ],
      ),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.connectedDevices.isEmpty) {
            return _buildEmptyState(context);
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.connectedDevices.length,
            itemBuilder: (context, index) {
              final device = state.connectedDevices[index];
              return _DeviceCard(device: device);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read<AppBloc>().add(const NetworkToggleRequested());
        },
        backgroundColor: AppConstants.primaryColor,
        icon: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return Icon(
              state.isNetworkActive ? Icons.stop : Icons.wifi_tethering,
            );
          },
        ),
        label: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return Text(state.isNetworkActive ? 'Stop Network' : 'Start Network');
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.devices_other,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No devices connected',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start the network to discover nearby devices',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<AppBloc>().add(const NetworkToggleRequested());
            },
            icon: const Icon(Icons.wifi_tethering),
            label: const Text('Start Network'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DeviceCard extends StatelessWidget {
  final dynamic device;

  const _DeviceCard({required this.device});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppConstants.primaryColor.withOpacity(0.2),
          child: const Icon(
            Icons.device_hub,
            color: AppConstants.primaryColor,
          ),
        ),
        title: Text(
          device.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${device.id.substring(0, 8)}...'),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: device.status.isConnected ? Colors.green : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  device.status.displayName,
                  style: TextStyle(
                    fontSize: 12,
                    color: device.status.isConnected ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showDeviceOptions(context, device),
        ),
      ),
    );
  }

  void _showDeviceOptions(BuildContext context, dynamic device) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              device.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Device ID', device.id),
            _buildInfoRow('Status', device.status.displayName),
            _buildInfoRow('Connected', device.connectedAt.toString().substring(0, 16)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  // Send message to device
                },
                icon: const Icon(Icons.message),
                label: const Text('Send Message'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppConstants.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
