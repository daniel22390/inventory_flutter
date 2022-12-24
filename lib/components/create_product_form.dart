import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inventory/components/product_image_picker.dart';
import 'package:inventory/core/models/inventory_product.dart';
import 'package:inventory/core/models/product_form_data.dart';
import 'package:inventory/utils/format_currency.dart';

class CreateProductForm extends StatefulWidget {
  final void Function(ProductFormData) onSubmit;

  const CreateProductForm({
    Key? key,
    required this.onSubmit,
  });

  @override
  State<CreateProductForm> createState() => _CreateProductFormState();
}

class _CreateProductFormState extends State<CreateProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = ProductFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              key: ValueKey('title'),
              initialValue: _formData.title,
              onChanged: (title) => _formData.title = title,
              decoration: InputDecoration(labelText: 'Título'),
              validator: (_title) {
                final title = _title ?? '';
                if (title.trim().length < 5) {
                  return 'Título deve ter no mínimo 5 caracteres.';
                }
                return null;
              },
            ),
            TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              key: ValueKey('description'),
              initialValue: _formData.description,
              onChanged: (description) => _formData.description = description,
              decoration: InputDecoration(labelText: 'Descrição'),
              validator: (_email) {
                return null;
              },
            ),
            TextFormField(
              key: ValueKey('price'),
              initialValue: _formData.price.toString(),
              onChanged: (price) {
                _formData.price = double.parse(price);
              },
              decoration: InputDecoration(labelText: 'Preço'),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
              ],
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (_price) {
                final price = _price ?? double.parse(_price!) ?? 0.0;
                if (price == 0.0) {
                  return 'Preço tem que ser maior que zero.';
                }
                return null;
              },
            ),
            TextFormField(
              key: ValueKey('quantity'),
              keyboardType: TextInputType.number,
              initialValue: "${_formData.quantity}",
              onChanged: (quantity) => _formData.quantity = int.parse(quantity),
              decoration: InputDecoration(labelText: 'Quantidade'),
              validator: (value) {
                if (value == null) {
                  return null;
                }
                final n = num.tryParse(value);
                if (n == null) {
                  return '"$value" is not a valid number';
                }
                return null;
              },
            ),
            TextFormField(
              key: ValueKey('barcode'),
              initialValue: _formData.barcode,
              onChanged: (barcode) => _formData.barcode = barcode,
              decoration: InputDecoration(labelText: 'Código de  Barras'),
              validator: (_value) {
                final value = _value ?? '';
                if (value.trim().length < 1) {
                  return 'Código de barras inválido.';
                }
                return null;
              },
            ),
            TextFormField(
              key: ValueKey('categoryId'),
              initialValue: _formData.categoryId,
              onChanged: (categoryId) => _formData.categoryId = categoryId,
              decoration: InputDecoration(labelText: 'Categoria'),
              validator: (_value) {
                final value = _value ?? '';
                if (value.trim().length < 1) {
                  return 'Categoria inválida.';
                }
                return null;
              },
            ),
            TextFormField(
              key: ValueKey('departmentId'),
              initialValue: _formData.departmentId,
              onChanged: (departmentId) =>
                  _formData.departmentId = departmentId,
              decoration: InputDecoration(labelText: 'Departamento'),
              validator: (_value) {
                final value = _value ?? '';
                if (value.trim().length < 1) {
                  return 'Departamento inválida.';
                }
                return null;
              },
            ),
            SizedBox(height: 12),
            ProductImagePicker(
              onImagePick: _handleImagePick,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
