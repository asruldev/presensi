// lib/providers/product_provider.dart
import 'package:flutter/material.dart';
import 'package:presentasi/models/product_model.dart';
import 'package:presentasi/services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _productService = ProductService();
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts({int limit = 10, int offset = 0}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _productService.getProducts(limit: limit, offset: offset);
    } catch (e) {
      print('Failed to load products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await _productService.addProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> updateProduct(int productId, Product product) async {
    try {
      final updatedProduct = await _productService.updateProduct(productId, product);
      final index = _products.indexWhere((p) => p.id == productId);
      if (index != -1) {
        _products[index] = updatedProduct;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating product: $e');
    }
  }
}
