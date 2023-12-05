import 'dart:io';

import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _image;

  Future<void> _getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile == null) {
      // User canceled the image selection
      return;
    }

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void _openImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_outlined),
                title: Text(LocaleKeys.profileView_photoCamera.tr()),
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(LocaleKeys.profileView_photoGallery.tr()),
                onTap: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _removePhoto() {
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.drawer_profile.tr()),
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          GestureDetector(
            onTap: _openImagePicker,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
                image: _image != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(_image!),
                      )
                    : null,
              ),
              child: _image == null
                  ? const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          _image != null
              ? ElevatedButton(
                  onPressed: _removePhoto,
                  child: Text(LocaleKeys.profileView_removePhoto.tr()),
                )
              : Container(),
        ],
      ),
    );
  }
}
