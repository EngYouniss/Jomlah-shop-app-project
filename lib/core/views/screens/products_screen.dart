import 'package:bazar_flow/core/models/product.dart';
import 'package:bazar_flow/core/viewmodels/productvm.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductVM prodVM = ProductVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: FutureBuilder<List<Product>>(
        future: prodVM.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              print("data is found");

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return Card(
                    child: Column(
                      children: [
                        Image.network(product.thumbnail),
                        ListTile(
                          title: Text(product.title),
                          subtitle: Text("\$${product.price}"),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text("No data found"));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
