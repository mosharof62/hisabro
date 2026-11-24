import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/onboarding/onboarding_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/dashboard/dashboard_screen.dart';
import '../../presentation/screens/products/products_screen.dart';
import '../../presentation/screens/products/add_product_screen.dart';
import '../../presentation/screens/customers/customers_screen.dart';
import '../../presentation/screens/customers/add_customer_screen.dart';
import '../../presentation/screens/invoices/invoices_screen.dart';
import '../../presentation/screens/invoices/create_invoice_screen.dart';
import '../../presentation/screens/expenses/expenses_screen.dart';
import '../../presentation/screens/reports/reports_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/profile/profile_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    // Splash
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),

    // Onboarding
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Auth
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),

    // Home (Main Navigation)
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
      routes: [
        // Dashboard
        GoRoute(
          path: 'dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),

        // Products
        GoRoute(
          path: 'products',
          name: 'products',
          builder: (context, state) => const ProductsScreen(),
          routes: [
            GoRoute(
              path: 'add',
              name: 'add-product',
              builder: (context, state) => const AddProductScreen(),
            ),
            GoRoute(
              path: 'edit/:id',
              name: 'edit-product',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return AddProductScreen(productId: id);
              },
            ),
          ],
        ),

        // Customers
        GoRoute(
          path: 'customers',
          name: 'customers',
          builder: (context, state) => const CustomersScreen(),
          routes: [
            GoRoute(
              path: 'add',
              name: 'add-customer',
              builder: (context, state) => const AddCustomerScreen(),
            ),
            GoRoute(
              path: 'edit/:id',
              name: 'edit-customer',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return AddCustomerScreen(customerId: id);
              },
            ),
          ],
        ),

        // Invoices
        GoRoute(
          path: 'invoices',
          name: 'invoices',
          builder: (context, state) => const InvoicesScreen(),
          routes: [
            GoRoute(
              path: 'create',
              name: 'create-invoice',
              builder: (context, state) => const CreateInvoiceScreen(),
            ),
            GoRoute(
              path: 'edit/:id',
              name: 'edit-invoice',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return CreateInvoiceScreen(invoiceId: id);
              },
            ),
          ],
        ),

        // Expenses
        GoRoute(
          path: 'expenses',
          name: 'expenses',
          builder: (context, state) => const ExpensesScreen(),
        ),

        // Reports
        GoRoute(
          path: 'reports',
          name: 'reports',
          builder: (context, state) => const ReportsScreen(),
        ),

        // Settings
        GoRoute(
          path: 'settings',
          name: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),

        // Profile
        GoRoute(
          path: 'profile',
          name: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],

  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Page not found',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            state.uri.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
);
