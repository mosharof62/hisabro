import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/app_constants.dart';
import '../../data/models/product.dart';
import '../../data/services/auth_service.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  final String? productId;

  const AddProductScreen({super.key, this.productId});

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _buyPriceController = TextEditingController();
  final _sellPriceController = TextEditingController();
  final _stockController = TextEditingController();
  final _lowStockLimitController = TextEditingController();
  final _barcodeController = TextEditingController();

  bool _isLoading = false;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    _isEditMode = widget.productId != null;
    _lowStockLimitController.text = '5';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _buyPriceController.dispose();
    _sellPriceController.dispose();
    _stockController.dispose();
    _lowStockLimitController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final auth = ref.read(authServiceProvider);
      final userId = auth.currentUser?.uid;

      if (userId == null) {
        throw Exception('User not authenticated');
      }

      final product = Product(
        id: widget.productId,
        userId: userId,
        name: _nameController.text.trim(),
        category: _categoryController.text.trim().isEmpty
            ? null
            : _categoryController.text.trim(),
        buyPrice: double.parse(_buyPriceController.text.trim()),
        sellPrice: double.parse(_sellPriceController.text.trim()),
        stock: int.parse(
          _stockController.text.trim().isEmpty
              ? '0'
              : _stockController.text.trim(),
        ),
        lowStockLimit: int.parse(
          _lowStockLimitController.text.trim().isEmpty
              ? '5'
              : _lowStockLimitController.text.trim(),
        ),
        barcode: _barcodeController.text.trim().isEmpty
            ? null
            : _barcodeController.text.trim(),
      );

      // TODO: Save to Supabase via repository
      // final repository = ref.read(productRepositoryProvider(userId));
      // if (_isEditMode) {
      //   await repository.update(product);
      // } else {
      //   await repository.create(product);
      // }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEditMode ? 'Product updated' : 'Product added'),
            backgroundColor: const Color(0xFF10B981),
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Product' : 'Add Product'),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _saveProduct,
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Product Name
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Product Name *',
                hintText: 'Enter product name',
                prefixIcon: Icon(Icons.inventory_2_outlined),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter product name';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Category Dropdown
            DropdownButtonFormField<String>(
              value: _categoryController.text.isEmpty
                  ? null
                  : _categoryController.text,
              decoration: const InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items:
                  const [
                    'Electronics',
                    'Grocery',
                    'Clothing',
                    'Hardware',
                    'Food',
                    'Other',
                  ].map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
              onChanged: (value) {
                _categoryController.text = value ?? '';
              },
            ),

            const SizedBox(height: 16),

            // Buy Price & Sell Price
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _buyPriceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Buy Price *',
                      prefixIcon: Icon(Icons.shopping_cart_outlined),
                      prefixText: '₹ ',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Required';
                      }
                      if (double.tryParse(value.trim()) == null) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _sellPriceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Sell Price *',
                      prefixIcon: Icon(Icons.sell_outlined),
                      prefixText: '₹ ',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Required';
                      }
                      if (double.tryParse(value.trim()) == null) {
                        return 'Invalid number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Stock & Low Stock Limit
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _stockController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Current Stock',
                      prefixIcon: Icon(Icons.inventory_outlined),
                    ),
                    validator: (value) {
                      if (value != null && value.trim().isNotEmpty) {
                        if (int.tryParse(value.trim()) == null) {
                          return 'Invalid number';
                        }
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _lowStockLimitController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Low Stock Alert',
                      prefixIcon: Icon(Icons.warning_amber_outlined),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Barcode
            TextFormField(
              controller: _barcodeController,
              decoration: InputDecoration(
                labelText: 'Barcode',
                hintText: 'Scan or enter barcode',
                prefixIcon: const Icon(Icons.qr_code),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () {
                    // TODO: Implement barcode scanner
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Profit Preview
            Card(
              color: theme.colorScheme.primary.withOpacity(0.05),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profit Preview',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Profit per unit:'),
                        Text(
                          _calculateProfit(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Profit margin:'),
                        Text(
                          _calculateMargin(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Save Button
            ElevatedButton(
              onPressed: _isLoading ? null : _saveProduct,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(_isEditMode ? 'Update Product' : 'Add Product'),
            ),
          ],
        ),
      ),
    );
  }

  String _calculateProfit() {
    final buyPrice = double.tryParse(_buyPriceController.text.trim()) ?? 0;
    final sellPrice = double.tryParse(_sellPriceController.text.trim()) ?? 0;
    final profit = sellPrice - buyPrice;
    return '₹${profit.toStringAsFixed(2)}';
  }

  String _calculateMargin() {
    final buyPrice = double.tryParse(_buyPriceController.text.trim()) ?? 0;
    final sellPrice = double.tryParse(_sellPriceController.text.trim()) ?? 0;
    if (buyPrice == 0) return '0%';
    final margin = ((sellPrice - buyPrice) / buyPrice * 100);
    return '${margin.toStringAsFixed(1)}%';
  }
}
