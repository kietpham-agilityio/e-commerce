import 'dart:async';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';

/// Debug Overlay Example Page
/// Demonstrates performance metrics and debug information
class DebugOverlayPage extends StatefulWidget {
  const DebugOverlayPage({super.key});

  @override
  State<DebugOverlayPage> createState() => _DebugOverlayPageState();
}

class _DebugOverlayPageState extends State<DebugOverlayPage> {
  Timer? _timer;
  int _fps = 60;
  double _memoryUsage = 45.2;
  int _networkRequests = 0;
  bool _isNetworkConnected = true;
  String _lastApiCall = 'GET /api/products - 200ms';
  int _buildCount = 0;

  @override
  void initState() {
    super.initState();
    _startMonitoring();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        // Simulate varying metrics
        _fps = 58 + (DateTime.now().millisecond % 4);
        _memoryUsage = 40 + (DateTime.now().millisecond % 20).toDouble();
        _buildCount++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      appBar: EcAppBar(title: const EcTitleMediumText('🔍 Debug Overlay')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Performance Metrics
            _buildSection(
              context,
              title: '📊 Performance Metrics',
              children: [
                _buildMetricCard(
                  context,
                  icon: Icons.speed,
                  title: 'Frame Rate (FPS)',
                  value: '$_fps',
                  subtitle: _fps >= 55 ? 'Excellent' : 'Poor',
                  color: _fps >= 55 ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 12),
                _buildMetricCard(
                  context,
                  icon: Icons.memory,
                  title: 'Memory Usage',
                  value: '${_memoryUsage.toStringAsFixed(1)} MB',
                  subtitle: _memoryUsage < 60 ? 'Normal' : 'High',
                  color: _memoryUsage < 60 ? Colors.green : Colors.orange,
                ),
                const SizedBox(height: 12),
                _buildMetricCard(
                  context,
                  icon: Icons.build,
                  title: 'Widget Rebuilds',
                  value: '$_buildCount',
                  subtitle: 'Total rebuilds',
                  color: Colors.blue,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Network Metrics
            _buildSection(
              context,
              title: '🌐 Network Status',
              children: [
                _buildMetricCard(
                  context,
                  icon: Icons.wifi,
                  title: 'Connection Status',
                  value: _isNetworkConnected ? 'Connected' : 'Disconnected',
                  subtitle: 'Network state',
                  color: _isNetworkConnected ? Colors.green : Colors.red,
                  trailing: Switch(
                    value: _isNetworkConnected,
                    onChanged: (value) {
                      setState(() {
                        _isNetworkConnected = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                _buildMetricCard(
                  context,
                  icon: Icons.cloud_sync,
                  title: 'API Requests',
                  value: '$_networkRequests',
                  subtitle: 'Total requests',
                  color: Colors.blue,
                ),
                const SizedBox(height: 12),
                _buildInfoCard(
                  context,
                  icon: Icons.access_time,
                  title: 'Last API Call',
                  value: _lastApiCall,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Debug Actions
            _buildSection(
              context,
              title: '🛠️ Debug Actions',
              children: [
                EcElevatedButton(
                  text: 'Simulate Network Request',
                  onPressed: _simulateNetworkRequest,
                ),
                const SizedBox(height: 12),
                EcElevatedButton(
                  text: 'Trigger Memory Spike',
                  onPressed: _triggerMemorySpike,
                ),
                const SizedBox(height: 12),
                EcElevatedButton(
                  text: 'Force Widget Rebuild',
                  onPressed: () => setState(() {}),
                ),
                const SizedBox(height: 12),
                EcElevatedButton(
                  text: 'Clear All Metrics',
                  onPressed: _clearMetrics,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // System Information
            _buildSection(
              context,
              title: 'ℹ️ System Information',
              children: [
                _buildInfoCard(
                  context,
                  icon: Icons.phone_android,
                  title: 'Platform',
                  value: 'iOS Simulator',
                ),
                const SizedBox(height: 8),
                _buildInfoCard(
                  context,
                  icon: Icons.info,
                  title: 'Flutter Version',
                  value: '3.27.0',
                ),
                const SizedBox(height: 8),
                _buildInfoCard(
                  context,
                  icon: Icons.code,
                  title: 'Dart Version',
                  value: '3.6.0',
                ),
                const SizedBox(height: 8),
                _buildInfoCard(
                  context,
                  icon: Icons.bug_report,
                  title: 'Build Mode',
                  value: 'Debug',
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Real-time Logs
            _buildSection(
              context,
              title: '📝 Recent Debug Logs',
              children: [
                _buildLogCard(
                  context,
                  '✅ API call completed - 200ms',
                  Colors.green,
                ),
                const SizedBox(height: 8),
                _buildLogCard(
                  context,
                  '⚠️ Cache miss for key: products',
                  Colors.orange,
                ),
                const SizedBox(height: 8),
                _buildLogCard(
                  context,
                  'ℹ️ User navigation to ProductDetails',
                  Colors.blue,
                ),
                const SizedBox(height: 8),
                _buildLogCard(
                  context,
                  '❌ Network request failed - Timeout',
                  Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EcTitleLargeText(title),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
    Widget? trailing,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EcBodySmallText(
                    title,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(height: 4),
                  EcTitleLargeText(value),
                  const SizedBox(height: 4),
                  EcBodySmallText(subtitle, color: color),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: colorScheme.primary, size: 20),
            const SizedBox(width: 12),
            Expanded(child: EcBodyMediumText(title)),
            EcBodyMediumText(value, color: colorScheme.secondary),
          ],
        ),
      ),
    );
  }

  Widget _buildLogCard(BuildContext context, String message, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(child: EcBodyMediumText(message)),
            EcBodySmallText(
              '${DateTime.now().hour}:${DateTime.now().minute}',
              color: Theme.of(context).colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }

  void _simulateNetworkRequest() {
    setState(() {
      _networkRequests++;
      _lastApiCall =
          'GET /api/users - ${100 + (DateTime.now().millisecond % 300)}ms';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('📡 Network request simulated'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _triggerMemorySpike() {
    setState(() {
      _memoryUsage = _memoryUsage + 15;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('📈 Memory spike triggered'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _clearMetrics() {
    setState(() {
      _networkRequests = 0;
      _buildCount = 0;
      _memoryUsage = 45.2;
      _fps = 60;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🧹 All metrics cleared'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
