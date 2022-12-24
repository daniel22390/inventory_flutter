import 'dart:ffi';

class InventoryProduct {
  final String id;
  final String title;
  final String description;
  final double price;
  final int quantity;
  final String barcode;
  final String imageUrl;
  final DateTime createdAt;
  final String categoryId;
  final String departmentId;


  const InventoryProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.barcode,
    required this.imageUrl,
    required this.createdAt,
    required this.categoryId,
    required this.departmentId
  });

}