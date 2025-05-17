import 'package:demaze_practical/screens/profile/provider/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ImagePickerProvider>(
      builder: (context, imageprovider, child) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          // color: Colors.black
        ),
        width: 140,
        height: 140,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: imageprovider.isFetching || imageprovider.isUploading
              ? const Center(child: CircularProgressIndicator())
              : Image(
                  image: imageprovider.imageUrl != null
                      ? Image.network(
                          imageprovider.imageUrl!,
                          key: UniqueKey(),
                        ).image
                      : const AssetImage("lib/assets/default.png"),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}
