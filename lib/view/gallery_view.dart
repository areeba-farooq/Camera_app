import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class GalleryView extends StatefulWidget {
  GalleryView({super.key, required this.file});
  XFile file;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  Widget build(BuildContext context) {
    File picture = File(widget.file.path);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Image.file(picture),
      ),
    );
  }
}
