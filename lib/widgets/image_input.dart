import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: const Text('Nenhuma imagem!'),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.camera),
          label: const Text('Tirar Foto'),
        ),
      ],
    );
  }
}
