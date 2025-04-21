import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';


//Provider class that helps to Upload and Crop the Selected Image
class ImagePickerProvider extends ChangeNotifier {
  File? _image;

  File? get image => _image;
  bool _isUploading = false;
  bool _isFetching = false;

  String? _imageUrl;

  String? get imageUrl => _imageUrl;

  bool get isUploading => _isUploading;

  bool get isFetching => _isFetching;

  final firebaseStorage = FirebaseStorage.instance;

  //Function to pick the image from the device
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _isUploading = true;
      notifyListeners();

      File? selectedFile = File(pickedFile.path);
      _image = await cropImage(selectedFile);

      try {
        final reference = firebaseStorage
            .ref()
            .child('profile_image')
            .child('user_profile.jpg');

        //Uploading the file on firebase storage
        await reference.putFile(_image!);

        //Get the image Url
        _imageUrl = await reference.getDownloadURL();
      } catch (e) {
        debugPrint("Error while uploading");
      }
      finally {
        _isUploading = false;
        notifyListeners();
      }
    }
  }

  //Fetching the uploaded profile from Firebase
  Future<void> fetchProfileImage() async {
    _isFetching = true;

    try {
      final reference = firebaseStorage
          .ref()
          .child('profile_image')
          .child('user_profile.jpg');
      _imageUrl = await reference.getDownloadURL();
    } catch (e) {
      _imageUrl = null;
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }


  //Method to Crop the Selected Image
  Future<File?> cropImage(File ImageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: ImageFile.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepPurple,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Custom Cropper',
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: false,
        ),
      ],
    );

    return File(croppedFile!.path);
  }
}
