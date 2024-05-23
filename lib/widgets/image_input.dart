import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  const ImageInput({
    super.key,
    required this.onSelectImage,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  _takePicture() async {
    final picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });

    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage!.copy(
      '${appDir.path}/$fileName',
    );

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 180,
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const Text('Nenhuma imagem!'),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: const Icon(Icons.camera),
            label: const Text('Tirar Foto'),
            style: ButtonStyle(
              textStyle: MaterialStatePropertyAll<TextStyle?>(
                TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
