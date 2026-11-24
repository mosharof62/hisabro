import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_today), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Summary Card
          Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.error.withOpacity(0.8),
                      theme.colorScheme.error,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Expenses',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '₹52,340',
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'This Month',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              )
              .animate()
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.2, end: 0, duration: 400.ms),

          // Expenses List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: 10,
              itemBuilder: (context, index) {
                final categories = [
                  'Rent',
                  'Utilities',
                  'Supplies',
                  'Salary',
                  'Transport',
                ];
                final icons = [
                  Icons.home,
                  Icons.lightbulb,
                  Icons.inventory,
                  Icons.person,
                  Icons.directions_car,
                ];
                final colors = [
                  const Color(0xFF6366F1),
                  const Color(0xFFF59E0B),
                  const Color(0xFF10B981),
                  const Color(0xFF8B5CF6),
                  const Color(0xFF06B6D4),
                ];

                final categoryIndex = index % categories.length;

                return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: colors[categoryIndex].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            icons[categoryIndex],
                            color: colors[categoryIndex],
                          ),
                        ),
                        title: Text(categories[categoryIndex]),
                        subtitle: Text('${index + 1} Nov 2026'),
                        trailing: Text(
                          '₹${(1000 + index * 500)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: (50 * index).ms, duration: 300.ms)
                    .slideX(begin: -0.2, end: 0, duration: 300.ms);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Expense'),
      ),
    );
  }
}
