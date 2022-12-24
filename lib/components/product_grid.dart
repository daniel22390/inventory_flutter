import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inventory/components/product_grid_item.dart';
import 'package:inventory/core/models/inventory_product.dart';
import 'package:inventory/core/services/product_service.dart';

class ProductGrid extends StatelessWidget {

  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<InventoryProduct>>(
      stream: ProductService().messagesStream(),
      builder: (ctx, snapshot) {
        print(snapshot.data);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhum produto disponível!'));
        } else {
          final products = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: products.length,
            itemBuilder: (ctx, i) => ProductGridItem(
              key: ValueKey(products[i].id),
              product: products[i]
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          );
        }
      }
    );
  }
}