import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inventory/core/models/inventory_product.dart';

class ProductGridItem extends StatelessWidget {
  final InventoryProduct product;

  const ProductGridItem({required this.product, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: Container(
          padding: const EdgeInsets.all(6),
          color: Colors.black54,
          height: 45,
          child: GridTileBar(
            title: Text(
              product.title,
            ),
            subtitle: Text("\R\$${product.price.toString()}")
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
