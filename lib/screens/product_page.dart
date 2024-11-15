import 'package:flutter/material.dart';
import 'package:presentasi/screens/add_product_page.dart';
import 'package:provider/provider.dart';
import 'package:presentasi/providers/product_provider.dart';
import 'package:presentasi/models/product_model.dart';
import 'update_product_page.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Produk')),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, _) {
          final products = productProvider.products;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product.name),
                subtitle: Text('Harga: \$${product.price}'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Arahkan ke halaman update produk
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProductPage(product: product),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
