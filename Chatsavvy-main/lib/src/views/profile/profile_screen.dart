import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pillwise/src/data/database/firebase_storage._helper.dart';
import 'package:pillwise/src/data/fire_store/fire_store_helper.dart';
import 'package:pillwise/src/data/fire_store/profile.dart';
import 'package:pillwise/src/models/my_user.dart';
import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/res/text_style.dart';
import 'package:pillwise/src/shared/utils/utils.dart';
import 'package:pillwise/src/shared/widgets/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = 'profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;

  late TextEditingController _emailController;

  late TextEditingController _phoneController;

  String? imagUrl;
  File? image;
  Future<File?> selectImage() async {
    image = await pickImageFromGallery(context);
    return image;
  }

  @override
  Widget build(BuildContext context) {
    var myUser = ModalRoute.of(context)!.settings.arguments as MyUser;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: headline5.copyWith(fontSize: 28),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder<MyUser>(
                  future: retriveUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: Column(
                          children: const [
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      MyUser user = snapshot.data!;
                      _emailController =
                          TextEditingController(text: user.email);
                      _nameController = TextEditingController(text: user.name);
                      _phoneController =
                          TextEditingController(text: user.phone);
                      return Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(20),
                              child: InkWell(
                                onTap: () => onUpload(),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    width: 150,
                                    height: 150,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black,
                                    ),
                                    child: const Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                  imageUrl: user.image,
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                          width: 150,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.contain),
                                          )),
                                ),
                              )),
                          CustomTextField(
                              controller: _nameController,
                              helperText: "Username"),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                              controller: _emailController,
                              helperText: "Email"),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                              controller: _phoneController,
                              helperText: "Phone"),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    MyUser user = MyUser(
                        id: myUser.id,
                        name: _nameController.text.trim(),
                        email: _emailController.text.trim(),
                        image: imagUrl ?? "2",
                        phone: _phoneController.text.trim());
                    await FireStoreHelper().updateUserInfo(user);
                    Future.delayed(
                      const Duration(seconds: 2),
                      () {
                        setState(() {});
                        Fluttertoast.showToast(
                            msg: "Profile was updated successfuly!",
                            fontSize: 18,
                            backgroundColor: primaryColor);
                      },
                    );

                    // addRoomViewModel.addRoomNavigator.navigateToHome();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style:
                        headline4.copyWith(fontSize: 22, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  onUpload() async {
    await selectImage();
    imagUrl = await FirebaseStorageHelper().addImageToDB(image);
    setState(() {});
  }
}
