import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class DetailScreen extends StatefulWidget {
  final String imageUrl;
  final String photographer;
  final String description;

  const DetailScreen({
    Key? key,
    required this.imageUrl,
    required this.photographer,
    required this.description,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isDownloading = false;
  bool _isLoadingGallery = false;

  Future<void> open(String filePath) async {
    await launch(filePath);
  }

  Future<void> downloadImage(String imageUrl, BuildContext context) async {
    setState(() {
      _isDownloading = true;
    });

    final http.Response response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.lightBlue,
          content: Text('Downloading started successfully!!!'),
          duration: Duration(seconds: 1),
        ),
      );

      final Directory appDirectory = await getTemporaryDirectory();
      final String filePath = '${appDirectory.path}/downloaded_image.jpg';

      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      await ImageGallerySaver.saveFile(filePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightBlue,
          action: SnackBarAction(
            label: 'Open',
            onPressed: () {
              open(filePath);
            },
          ),
          content: Text('Successfully Downloaded!!!'),
          duration: Duration(seconds: 1),
        ),
      );

      setState(() {
        _isDownloading = false;
      });

      print('Image downloaded and saved to gallery');
    } else {
      print('Failed to download image: ${response.statusCode}');
      setState(() {
        _isDownloading = false;
      });
    }
  }

  // Function to open the image in the device's gallery
  Future<void> openInGallery(BuildContext context) async {
    setState(() {
      _isLoadingGallery = true;
    });

    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bool success = await ImageGallerySaver.saveFile(image.path);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.lightBlue,
            content: Text('Image opened in gallery!!!'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        print('Failed to open image in gallery');
      }
    }

    setState(() {
      _isLoadingGallery = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 100,
                  child: ElevatedButton(
                    onPressed: _isDownloading
                        ? null
                        : () {
                            downloadImage(widget.imageUrl, context);
                          },
                    child: _isDownloading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text('Download'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Photographer: ${widget.photographer}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Text(
                'Description: ${widget.description}',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoadingGallery
                  ? null
                  : () {
                      openInGallery(context);
                    },
              child: _isLoadingGallery
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : Text('Open in Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
