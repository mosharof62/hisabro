import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Refresh data
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Card
              _buildWelcomeCard(context, theme),

              const SizedBox(height: 20),

              // Quick Stats
              _buildQuickStats(context, theme),

              const SizedBox(height: 20),

              // Quick Actions
              Text('Quick Actions', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              _buildQuickActions(context, theme),

              const SizedBox(height: 20),

              // Recent Activity
              Text('Recent Activity', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),
              _buildRecentActivity(context, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context, ThemeData theme) {
    return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back!',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Here\'s your business overview',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.business_center,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.2, end: 0, duration: 400.ms);
  }

  Widget _buildQuickStats(BuildContext context, ThemeData theme) {
    final stats = [
      _StatItem(
        title: 'Today\'s Sales',
        value: '₹15,240',
        icon: Icons.trending_up,
        color: const Color(0xFF10B981),
        change: '+12.5%',
      ),
      _StatItem(
        title: 'Total Revenue',
        value: '₹2,45,680',
        icon: Icons.account_balance_wallet,
        color: const Color(0xFF6366F1),
        change: '+8.2%',
      ),
      _StatItem(
        title: 'Pending',
        value: '₹8,420',
        icon: Icons.pending_actions,
        color: const Color(0xFFF59E0B),
        change: '-3.1%',
      ),
      _StatItem(
        title: 'Profit',
        value: '₹45,230',
        icon: Icons.payments,
        color: const Color(0xFF8B5CF6),
        change: '+15.8%',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return _buildStatCard(context, theme, stat, index);
      },
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    ThemeData theme,
    _StatItem stat,
    int index,
  ) {
    return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: stat.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(stat.icon, color: stat.color, size: 20),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: stat.change.startsWith('+')
                            ? const Color(0xFF10B981).withOpacity(0.1)
                            : const Color(0xFFEF4444).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        stat.change,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: stat.change.startsWith('+')
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stat.value,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(stat.title, style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: (100 * index).ms, duration: 400.ms)
        .slideY(begin: 0.2, end: 0, duration: 400.ms);
  }

  Widget _buildQuickActions(BuildContext context, ThemeData theme) {
    final actions = [
      _ActionItem(
        title: 'New Invoice',
        icon: Icons.receipt_long,
        color: const Color(0xFF6366F1),
      ),
      _ActionItem(
        title: 'Add Product',
        icon: Icons.inventory_2,
        color: const Color(0xFF8B5CF6),
      ),
      _ActionItem(
        title: 'Add Customer',
        icon: Icons.person_add,
        color: const Color(0xFF06B6D4),
      ),
      _ActionItem(
        title: 'Reports',
        icon: Icons.analytics,
        color: const Color(0xFF10B981),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.9,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        return _buildActionCard(context, theme, action, index);
      },
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    ThemeData theme,
    _ActionItem action,
    int index,
  ) {
    return Card(
          child: InkWell(
            onTap: () {
              // TODO: Navigate to respective screen
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: action.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(action.icon, color: action.color, size: 24),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    action.title,
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: (100 * index).ms, duration: 400.ms)
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 400.ms,
        );
  }

  Widget _buildRecentActivity(BuildContext context, ThemeData theme) {
    return Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.receipt_long,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                title: Text('Invoice #INV${1000 + index}'),
                subtitle: Text('Customer ${index + 1} • 2 items'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${(1500 + index * 500)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text('2h ago', style: theme.textTheme.bodySmall),
                  ],
                ),
              );
            },
          ),
        )
        .animate()
        .fadeIn(delay: 400.ms, duration: 400.ms)
        .slideY(begin: 0.2, end: 0, duration: 400.ms);
  }
}

class _StatItem {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String change;

  _StatItem({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.change,
  });
}

class _ActionItem {
  final String title;
  final IconData icon;
  final Color color;

  _ActionItem({required this.title, required this.icon, required this.color});
}
