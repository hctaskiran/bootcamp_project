import 'dart:io';

import 'package:bootcamp_project/components/widgets/choose_pp.dart';
import 'package:bootcamp_project/constants/colors.dart';
import 'package:bootcamp_project/constants/sized_box.dart';
import 'package:bootcamp_project/init/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? _image;
  late String _userName = "";
  late String _userPhoneNumber = "";

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? '';
      _userPhoneNumber = prefs.getString('user_phone_number') ?? '';
    });
  }

  void _removePhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('profile_image');

    setState(() {
      _image = null;
    });
  }

  Future<void> _getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('profile_image', pickedFile.path);

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

  void _editUserInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.profileView_editProfile.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _userName = value;
                  });
                },
                decoration: InputDecoration(labelText: LocaleKeys.profileView_userName.tr()),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _userPhoneNumber = value;
                  });
                },
                decoration: InputDecoration(labelText: LocaleKeys.profileView_userPhone.tr()),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: CColor.blu100, foregroundColor: Colors.white),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('user_name', _userName);
                prefs.setString('user_phone_number', _userPhoneNumber);
                Navigator.pop(context);
              },
              child: Text(LocaleKeys.profileView_save.tr()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.drawer_profile.tr()),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SB.h40,
          Center(
            child: InkWell(
              onTap: _openImagePicker,
              child: ChoosePP(image: _image),
            ),
          ),
          SB.h20,
          _image != null
              ? ElevatedButton(
                  onPressed: _removePhoto,
                  child: Text(
                    LocaleKeys.profileView_removePhoto.tr(),
                  ))
              : Container(),
          SB.h20,
          ListTile(
            title: Text("${LocaleKeys.profileView_userName.tr()}:\n $_userName", style: TextStyle(color: CColor.black)),
            onTap: _editUserInfo,
          ),
          SB.h10,
          ListTile(
            title: Text(
              "${LocaleKeys.profileView_userPhone.tr()}:\n $_userPhoneNumber",
              style: TextStyle(color: CColor.black),
            ),
            onTap: _editUserInfo,
          ),
          SB.h20,
        ],
      ),
    );
  }
}
