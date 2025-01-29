import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sub_share_me/constants/app_colors.dart';

class FullScreenImage extends StatefulWidget {
  final File? file;
  final String fileName;
  final String? date;

  const FullScreenImage({
    Key? key,
    required this.file,
    required this.fileName,
    required this.date,
  }) : super(key: key);

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    if (widget.file == null) {
      return _buildErrorView();
    }

    final fileExtension = widget.file!.path.split('.').last.toLowerCase();

    if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png' || fileExtension == 'gif') {
      return _buildImageView();
    } else {
      return _buildUnsupportedView();
    }
  }

  Widget _buildImageView() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        leading: IconButton(
          icon: const Icon(Icons.backspace, color: AppColors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.date}',
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          '${widget.fileName}',
                          style: const TextStyle(
                            color: AppColors.grey,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.white),
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Delete',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                margin: const EdgeInsets.only(right: 4),
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'SHARE',
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: AppColors.bg,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PhotoView(
          imageProvider: FileImage(widget.file!),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          basePosition: Alignment.center,
          loadingBuilder: (context, event) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.grey,),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUnsupportedView() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Unsupported File Type',
          style: TextStyle(color: AppColors.black, fontSize: 13, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'The selected file type is not supported for viewing.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Error',
          style: TextStyle(color: AppColors.black, fontSize: 13, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'No file selected or an error occurred.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
