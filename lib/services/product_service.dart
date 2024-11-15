// lib/services/product_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:presentasi/models/product_model.dart';
import 'package:presentasi/utils/storage_helper.dart';

class ProductService {
  final String _baseUrl = 'http://127.0.0.1:8888';

  Future<Product> updateProduct(int productId, Product product) async {
    final String? accessToken = await StorageHelper.getAccessToken();
    if (accessToken == null) {
      throw Exception("Access Token tidak ditemukan");
    }

    final Uri url = Uri.parse('$_baseUrl/products/$productId');
    final headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    final body = json.encode(product.toJson());

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mengupdate produk');
    }
  }

  Future<Product> addProduct(Product product) async {
    final String? accessToken = await StorageHelper.getAccessToken();
    if (accessToken == null) {
      throw Exception("Access Token tidak ditemukan");
    }

    final Uri url = Uri.parse('$_baseUrl/products');
    final headers = {
      'accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };

    final body = json.encode(product.toJson());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal menambahkan produk');
    }
  }

  Future<List<Product>> getProducts({int limit = 10, int offset = 0}) async {
    final Uri url = Uri.parse('$_baseUrl/products?limit=$limit&offset=$offset');
    final response = await http.get(url, headers: {'accept': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
