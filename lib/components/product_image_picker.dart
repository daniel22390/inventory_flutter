import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagePicker extends StatefulWidget {
  final void Function(File image) onImagePick;

  const ProductImagePicker({
    Key? key,
    required this.onImagePick,
  }) : super(key: key);

  @override
  _ProductImagePickerState createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      widget.onImagePick(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color: Colors.grey,
          ),
          child: _image !=  null ? Image.file(
            _image!,
            fit: BoxFit.cover,
          ) : null,
        ),
        TextButton(
          onPressed: _pickImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10),
              Text('Adicionar Imagem')
            ],
          ),
        ),
      ],
    );
  }
}
