import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dashboard/dashboard_screen.dart';
import '../products/products_screen.dart';
import '../invoices/invoices_screen.dart';
import '../expenses/expenses_screen.dart';
import '../settings/settings_screen.dart';

final homeIndexProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homeIndexProvider);

    final screens = [
      const DashboardScreen(),
      const ProductsScreen(),
      const InvoicesScreen(),
      const ExpensesScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          ref.read(homeIndexProvider.notifier).state = index;
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Products',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Invoices',
          ),
          NavigationDestination(
            icon: Icon(Icons.money_off_outlined),
            selectedIcon: Icon(Icons.money_off),
            label: 'Expenses',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      floatingActionButton:
          currentIndex ==
              2 // Show FAB only on Invoices screen
          ? FloatingActionButton.extended(
              onPressed: () {
                // Navigate to create invoice
              },
              icon: const Icon(Icons.add),
              label: const Text('New Invoice'),
            )
          : null,
    );
  }
}
