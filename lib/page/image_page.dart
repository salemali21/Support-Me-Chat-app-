import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path/path.dart';

import '../api/firebase_api.dart';
import '../model/firebase_file.dart';

class ImagePage extends StatelessWidget {
  final FirebaseFile file;
  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);
  void loadImage() async {
    var imageId = await ImageDownloader.downloadImage(file.url);

  }
  @override
  Widget build(BuildContext context) {
    final isImage = ['.jpeg', '.jpg', '.png'].any(file.name.contains);

    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () async {
              loadImage();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Downloaded ${file.name}'),));
            }),
          const SizedBox(width: 12),
        ],
      ),
      body: isImage
          ? Image.network(
        file.url,
        height: double.infinity,
        fit: BoxFit.cover,
      )
          : Center(
        child: Text(
          'Cannot be displayed',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}