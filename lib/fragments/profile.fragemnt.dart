import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../providers/profile.provider.dart';
import '../Locale/locales.dart';
import '../providers/user.provider.dart';

class MLProfileFragment extends StatefulWidget {
  static String tag = '/MLProfileFragment';

  const MLProfileFragment({Key? key}) : super(key: key);

  @override
  MLProfileFragmentState createState() => MLProfileFragmentState();
}

class MLProfileFragmentState extends State<MLProfileFragment> {
  late File? _pickedImage;
  String downloadURL = '';
  String hasImage = '';
  String? _gender;

  @override
  void initState() {
    init();
    getGender();
    super.initState();
  }

  Future<void> init() async {
    Future.delayed(Duration.zero, () async {
      Provider.of<ProfileProvider>(context, listen: false).getProfile();
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    uploadFile(pickedImageFile);
  }

  Future<void> reloadPage() async {
    Navigator.pop(context);
    // Navigator.pushNamed(context, "setting");
  }

  Future<void> _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    uploadFile(pickedImageFile);
  }

  Future<void> _remove() async {
    try {
      await AppUser.instance.user!.updatePhotoURL(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png');
      await Future.delayed(const Duration(seconds: 3), reloadPage);
      Fluttertoast.showToast(msg: 'Picture successfully removed');
    } catch (e) {
      debugPrint('Error deleting $_pickedImage: $e');
    }
  }

  Future<void> uploadFile(File f) async {
    var locale = AppLocalizations.of(context)!;
    File file = f;
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('/UserImages/${AppUser.instance.user!.uid}.png')
          .putFile(file);
      String d = await firebase_storage.FirebaseStorage.instance
          .ref('/UserImages/${AppUser.instance.user!.uid}.png')
          .getDownloadURL();
      await AppUser.instance.user!.updatePhotoURL(d);
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: locale.success1!,
        ),
      );
      Provider.of<ProfileProvider>(context, listen: false).getProfile();
    } catch (e) {
      print(e.toString());
      // e.g, e.code == 'canceled'
    }
  }

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final color = const Color(0xfffff9d4);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return SafeArea(child: Consumer<ProfileProvider>(builder: (context, data, child) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: <Widget>[
                          const SizedBox(height: 32.0),
                          CircleAvatar(
                              radius: 48,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(data.url != ''
                                    ? data.url
                                    : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png'),
                                radius: 55,
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: ClipOval(
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                      locale.option_profile!,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: Colors.transparent,
                                                      ),
                                                    ),
                                                    content:
                                                    SingleChildScrollView(
                                                      child: ListBody(
                                                        children: [
                                                          (_gender == "Male" ||
                                                              _gender ==
                                                                  "Lelaki")
                                                              ? Container(
                                                                height: MediaQuery.of(context)
                                                                    .size
                                                                    .height /
                                                                    5,
                                                                width: MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                    1.2,
                                                                child:
                                                                Column(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                                  children: <
                                                                      Widget>[
                                                                    Expanded(
                                                                      child:
                                                                      ListView(
                                                                        scrollDirection:
                                                                        Axis.horizontal,
                                                                        children: <Widget>[
                                                                          MaterialButton(
                                                                            onPressed: () async {
                                                                              String d = await firebase_storage.FirebaseStorage.instance.ref('/avatar/male1.png').getDownloadURL();
                                                                              await AppUser.instance.user!.updatePhotoURL(d);
                                                                              await init();
                                                                              showTopSnackBar(
                                                                                context,
                                                                                CustomSnackBar.success(
                                                                                  message: locale.success1!,
                                                                                ),
                                                                              );
                                                                              reloadPage();
                                                                            },
                                                                            child: Material(
                                                                              borderRadius: BorderRadius.circular(25.0),
                                                                              color: Colors.white,
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width / 5,
                                                                                height: MediaQuery.of(context).size.width / 5,
                                                                                child: Image.asset(
                                                                                  'avatar/male1.png',
                                                                                  height: 30,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          MaterialButton(
                                                                            onPressed: () async {
                                                                              String d = await firebase_storage.FirebaseStorage.instance.ref('/avatar/male2.png').getDownloadURL();
                                                                              await AppUser.instance.user!.updatePhotoURL(d);
                                                                              await init();
                                                                              showTopSnackBar(
                                                                                context,
                                                                                CustomSnackBar.success(
                                                                                  message: locale.success1!,
                                                                                ),
                                                                              );
                                                                              reloadPage();
                                                                            },
                                                                            child: Material(
                                                                              borderRadius: BorderRadius.circular(25.0),
                                                                              color: Colors.white,
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width / 5,
                                                                                height: MediaQuery.of(context).size.width / 5,
                                                                                child: Image.asset(
                                                                                  'avatar/male2.png',
                                                                                  height: 30,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          MaterialButton(
                                                                            onPressed: () async {
                                                                              String d = await firebase_storage.FirebaseStorage.instance.ref('/avatar/male3.png').getDownloadURL();
                                                                              await AppUser.instance.user!.updatePhotoURL(d);
                                                                              await init();
                                                                              showTopSnackBar(
                                                                                context,
                                                                                CustomSnackBar.success(
                                                                                  message: locale.success1!,
                                                                                ),
                                                                              );
                                                                              reloadPage();
                                                                            },
                                                                            child: Material(
                                                                              borderRadius: BorderRadius.circular(25.0),
                                                                              color: Colors.white,
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width / 5,
                                                                                height: MediaQuery.of(context).size.width / 5,
                                                                                child: Image.asset(
                                                                                  'avatar/male3.png',
                                                                                  height: 30,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          MaterialButton(
                                                                            onPressed: () async {
                                                                              String d = await firebase_storage.FirebaseStorage.instance.ref('/avatar/male4.png').getDownloadURL();
                                                                              await AppUser.instance.user!.updatePhotoURL(d);
                                                                              await init();
                                                                              showTopSnackBar(
                                                                                context,
                                                                                CustomSnackBar.success(
                                                                                  message: locale.success1!,
                                                                                ),
                                                                              );
                                                                              reloadPage();
                                                                            },
                                                                            child: Material(
                                                                              borderRadius: BorderRadius.circular(25.0),
                                                                              color: Colors.white,
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width / 5,
                                                                                height: MediaQuery.of(context).size.width / 5,
                                                                                child: Image.asset(
                                                                                  'avatar/male4.png',
                                                                                  height: 30,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          MaterialButton(
                                                                            onPressed: () async {
                                                                              String d = await firebase_storage.FirebaseStorage.instance.ref('/avatar/male5.png').getDownloadURL();
                                                                              await AppUser.instance.user!.updatePhotoURL(d);
                                                                              await init();
                                                                              showTopSnackBar(
                                                                                context,
                                                                                CustomSnackBar.success(
                                                                                  message: locale.success1!,
                                                                                ),
                                                                              );
                                                                              reloadPage();
                                                                            },
                                                                            child: Material(
                                                                              borderRadius: BorderRadius.circular(25.0),
                                                                              color: Colors.white,
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width / 5,
                                                                                height: MediaQuery.of(context).size.width / 5,
                                                                                child: Image.asset(
                                                                                  'avatar/male5.png',
                                                                                  height: 30,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                          )
                                                              : Container(
                                                            height: MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                                5,
                                                            width: MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                                1.2,
                                                            child:
                                                            Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                              children: <
                                                                  Widget>[
                                                                Expanded(
                                                                  child:
                                                                  ListView(
                                                                    scrollDirection:
                                                                    Axis.horizontal,
                                                                    children: <Widget>[
                                                                      MaterialButton(
                                                                        onPressed: () async {
                                                                          String d = await firebase_storage.FirebaseStorage.instance.ref('/avatar/female1.png').getDownloadURL();
                                                                          await AppUser.instance.user!.updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child: Material(
                                                                          borderRadius: BorderRadius.circular(25.0),
                                                                          color: Colors.white,
                                                                          child: Container(
                                                                            width: MediaQuery.of(context).size.width / 5,
                                                                            height: MediaQuery.of(context).size.width / 5,
                                                                            child: Image.asset(
                                                                              'avatar/female1.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed: () async {
                                                                          String d = await firebase_storage.FirebaseStorage.instance.ref('/avatar/female2.png').getDownloadURL();
                                                                          await AppUser.instance.user!.updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child: Material(
                                                                          borderRadius: BorderRadius.circular(25.0),
                                                                          color: Colors.white,
                                                                          child: Container(
                                                                            width: MediaQuery.of(context).size.width / 5,
                                                                            height: MediaQuery.of(context).size.width / 5,
                                                                            child: Image.asset(
                                                                              'avatar/female2.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed: () async {
                                                                          String d = await firebase_storage.FirebaseStorage.instance.ref('/avatar/female3.png').getDownloadURL();
                                                                          await AppUser.instance.user!.updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child: Material(
                                                                          borderRadius: BorderRadius.circular(25.0),
                                                                          color: Colors.white,
                                                                          child: Container(
                                                                            width: MediaQuery.of(context).size.width / 5,
                                                                            height: MediaQuery.of(context).size.width / 5,
                                                                            child: Image.asset(
                                                                              'avatar/female3.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed: () async {
                                                                          String d = await firebase_storage.FirebaseStorage.instance.ref('/avatar/female4.png').getDownloadURL();
                                                                          await AppUser.instance.user!.updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child: Material(
                                                                          borderRadius: BorderRadius.circular(25.0),
                                                                          color: Colors.white,
                                                                          child: Container(
                                                                            width: MediaQuery.of(context).size.width / 5,
                                                                            height: MediaQuery.of(context).size.width / 5,
                                                                            child: Image.asset(
                                                                              'avatar/female4.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed: () async {
                                                                          String d = await firebase_storage.FirebaseStorage.instance.ref('/avatar/female5.png').getDownloadURL();
                                                                          await AppUser.instance.user!.updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child: Material(
                                                                          borderRadius: BorderRadius.circular(25.0),
                                                                          color: Colors.white,
                                                                          child: Container(
                                                                            width: MediaQuery.of(context).size.width / 5,
                                                                            height: MediaQuery.of(context).size.width / 5,
                                                                            child: Image.asset(
                                                                              'avatar/female5.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              _pickImageCamera();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            splashColor:
                                                            Colors.blue,
                                                            child: Row(
                                                              children: [
                                                                const Padding(
                                                                  padding:
                                                                  EdgeInsets.all(
                                                                      8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .camera,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  locale
                                                                      .camera_profile!,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                      18,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: Colors
                                                                          .blue),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              _pickImageGallery();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            splashColor:
                                                            Colors.blue,
                                                            child: Row(
                                                              children: [
                                                                const Padding(
                                                                  padding:
                                                                  EdgeInsets.all(
                                                                      8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .image,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  locale
                                                                      .gallery_profile!,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                      18,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: Colors
                                                                          .blue),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              _remove();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            splashColor:
                                                            Colors.blue,
                                                            child: Row(
                                                              children: [
                                                                const Padding(
                                                                  padding:
                                                                  EdgeInsets.all(
                                                                      8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove_circle,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  locale
                                                                      .remove_profile!,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                      18,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      color: Colors
                                                                          .red),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.white,
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.black,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> getGender() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users')
        .doc(AppUser.instance.user!.uid)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          _gender = value['gender'];
          print("Gender $_gender");
        });
      }
    }).catchError((e) {
      if (mounted) {
        setState(() {
          _gender = '';
        });
      }
    });
  }
}
