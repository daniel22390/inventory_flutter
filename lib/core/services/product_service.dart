import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:inventory/core/models/inventory_product.dart';

class ProductService {
  Stream<List<InventoryProduct>> messagesStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('products')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  Future<InventoryProduct?> create({  
    title,
    description,
    price,
    quantity,
    barcode,
    categoryId,
    departmentId,
    image
  }) async {
    final store = FirebaseFirestore.instance;
    final imageName = '${DateTime.now().toIso8601String()}}.jpg';
    final imageURL = await _uploadProductImage(image, imageName);

    final product = InventoryProduct(
      id: Random().nextDouble().toString(),
      title: title,
      description: description,
      price: price,
      quantity: quantity,
      barcode: barcode,
      categoryId: categoryId,
      departmentId: departmentId,
      imageUrl: imageURL!,
      createdAt: DateTime.now(),
    );

    final docRef = await store
        .collection('products')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(product);

    final doc = await docRef.get();
    return doc.data()!;
  }

  Future<String?> _uploadProductImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('product_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  // ChatMessage => Map<String, dynamic>
  Map<String, dynamic> _toFirestore(
    InventoryProduct product,
    SetOptions? options,
  ) {
    return {
      'title': product.title,
      'description': product.description,
      'price': product.price,
      'quantity': product.quantity,
      'barcode': product.barcode,
      'imageUrl': product.imageUrl,
      'createdAt': product.createdAt.toIso8601String(),
      'categoryId': product.categoryId,
      'departmentId': product.departmentId,
    };
  }

  // Map<String, dynamic> => ChatMessage
  InventoryProduct _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return InventoryProduct(
      id: doc.id,
      title: doc['title'],
      description: doc['description'],
      price: doc['price'],
      quantity: doc['quantity'],
      barcode: doc['barcode'],
      imageUrl: doc['imageUrl'],
      createdAt: DateTime.parse(doc['createdAt']),
      categoryId: doc['categoryId'],
      departmentId: doc['departmentId'],
    );
  }
}