import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inventory/components/product_grid.dart';
import 'package:inventory/components/product_grid_item.dart';

class ListProductsScreen extends StatelessWidget {
  const ListProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          children: [
            Expanded(child: ProductGrid())
          ],
        ),
    );
  }
}