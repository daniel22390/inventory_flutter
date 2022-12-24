import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inventory/components/create_product_form.dart';
import 'package:inventory/core/models/inventory_product.dart';
import 'package:inventory/core/models/product_form_data.dart';
import 'package:inventory/core/services/product_service.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  bool _isLoading = false;

  Future<void> _handleSubmit(ProductFormData formData) async {
    try {
      setState(() => _isLoading = true);

      await ProductService().create(
        title: formData.title,
        description: formData.description,
        price: formData.price,
        quantity: formData.quantity,
        barcode: formData.barcode,
        categoryId: formData.categoryId,
        departmentId: formData.departmentId,
        image: formData.image
      );
      Navigator.of(context).pop();

    } catch (error) {
      print(error.toString());
      // Tratar erro!
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produto'),
      ),
      body:  Stack(
        children: [
          SingleChildScrollView(
            child: CreateProductForm(onSubmit: _handleSubmit),
          ),
          if (_isLoading)
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}