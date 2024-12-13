import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:true_purity/custom_theme/custom_button.dart';
import 'package:true_purity/helpers/widgets.dart';
import 'package:http/http.dart' as http;

import '../custom_theme/color_palette.dart';

class UserProfile extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final BoxConstraints? constraints;
  final double? imagesSize;

  const UserProfile(
      {super.key, this.constraints, this.imagesSize, this.scaffoldKey});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? currentUserId;
  String userName = '';
  String userEmail = '';
  String imageUrl = '';

  void _getUserInfo() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        setState(() {
          currentUserId = currentUser.uid;
        });
      }
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      final data = querySnapshot.data();

      setState(() {
        userName = data?['username'];
        userEmail = data?['email'];
        imageUrl = data?['image_url'];
      });

      debugPrint('email: $userEmail');
      debugPrint('username: $userName');
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double imageSize = widget.imagesSize ?? 60.0;
    if (currentUserId == null) {
      return const Center(child: CircularProgressIndicator(color: Colors.blue));
    }
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 10),
      constraints: widget.constraints,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(width: 2, color: Colors.black),
                ),
                child: imageUrl != ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(imageUrl, fit: BoxFit.cover))
                    : const Icon(
                        FontAwesomeIcons.user,
                        size: 25,
                      ),
              ),
              Positioned(
                left: imageSize - 18,
                top: imageSize - 18,
                child: GestureDetector(
                  onTap: () {
                    widget.scaffoldKey?.currentState!.closeDrawer();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            alignment: Alignment.center,

                            // surfaceTintColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Rounded corners
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                CloseButton()
                              ],
                            ),
                            backgroundColor: ColorPalette.background,
                            // contentPadding: const EdgeInsets.all(0),
                            content: IntrinsicHeight(
                                child: EditProfileContent(
                              userInfo: {
                                'username': userName,
                                'email': userEmail,
                                'imageUrl': imageUrl,
                              },
                            )),
                          );
                        });
                  },
                  child: const Icon(
                    FontAwesomeIcons.penToSquare,
                    color: Colors.black,
                    size: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                userName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                userEmail,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
    );
  }
}

class EditProfileContent extends StatefulWidget {
  final Map<String, String> userInfo;
  const EditProfileContent({super.key, required this.userInfo});

  @override
  State<EditProfileContent> createState() => _EditProfileContentState();
}

class _EditProfileContentState extends State<EditProfileContent> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      nameController.text = widget.userInfo['username']!;
    });
    super.initState();
  }

  bool isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final currentUserId = FirebaseAuth.instance.currentUser?.uid;
  PlatformFile? _pickedImage;

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      PlatformFile file = result.files.single;
      // String fileName = file.name;
      setState(() {
        _pickedImage = file;
      });
    }
  }

  Future<void> saveName() async {
    setState(() {
      isLoading = true;
    });
    if (nameController.text == widget.userInfo['username']!.toLowerCase())
      return;
    if (_formKey.currentState?.validate() ?? false) {
      await _firestore.collection('users').doc(currentUserId).update({
        'username': nameController.text,
      });
    }
  }

  Future<void> saveUserPhoto() async {
    if (_pickedImage == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    setState(() {
      isLoading = true;
    });
    try {
      // Cloudinary details
      const String cloudName = 'dnmoghdre';
      const String uploadPreset = 'true_purity';
      final Uri cloudinaryUrl =
          Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

      // Upload to Cloudinary
      var request = http.MultipartRequest('POST', cloudinaryUrl);
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          _pickedImage!.bytes!,
          filename: _pickedImage!.name,
        ),
      );

      var response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);
        final String imageUrl = jsonResponse['secure_url'];
        debugPrint('Working.....');
        // Update Firestore with the image URL and username
        await _firestore.collection('users').doc(currentUserId).update({
          'image_url': imageUrl,
        });

        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to upload image: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    }
  }

  void saveUserInfo() async {
    await saveName();
    await saveUserPhoto();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // bool isMobile = MediaQuery.of(context).size.width < 720;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 2, color: Colors.black),
              ),
              child: _pickedImage != null
                  ? Image.memory(
                      _pickedImage!.bytes!,
                      // width: 300,
                      // height: 300,
                      fit: BoxFit.cover,
                    )
                  : widget.userInfo['imageUrl'] != ''
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            widget.userInfo['imageUrl']!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Icon(
                          FontAwesomeIcons.user,
                          size: 25,
                        ),
            ),
            GestureDetector(
              onTap: _pickImage,
              child: CustomText(
                text: 'Change Photo',
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            )
          ],
        ),
        SizedBox(height: 20),
        Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Change user name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  autofocus: true,
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4) {
                      return value!.isEmpty
                          ? 'Please enter your username'
                          : 'Username must be more than 3 characters';
                    }
                    return null;
                  },
                ),
              ],
            )),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : CustomButton(
                      text: 'Save',
                      color: Colors.black,
                      onPressed: () {
                        saveUserInfo();
                      },
                      padding: EdgeInsets.all(5),
                    ),
            ],
          ),
        )
      ],
    );
  }
}
// gDfQ6iIhGbiePCzhz3UdBPSRibU API SECRETE
// 144854877539192   API KEY
// CLOUDINARY_URL=cloudinary://<your_api_key>:<your_api_secret>@dnmoghdre











