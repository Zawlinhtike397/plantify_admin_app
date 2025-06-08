import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Products extends StatelessWidget {
  const Products({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              const Text('Got something new to offer?'),
              ElevatedButton(
                onPressed: () {
                  context.go('/products/add-product');
                },
                child: const Text('Add Product'),
              ),
            ],
          )
        ],
      )),
    );
  }
}
