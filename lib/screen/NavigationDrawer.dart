import 'package:flutter/material.dart';
import 'package:istiqamah_app/screen/fill_inform_page.dart';
import 'package:istiqamah_app/screen/helpdesk_page.dart';
import 'package:istiqamah_app/screen/next_profile_form_component.dart';
import 'package:istiqamah_app/screen/sadaqah_page.dart';
import 'package:istiqamah_app/screen/setting_page.dart';
import 'package:nb_utils/nb_utils.dart';
import '../Locale/locales.dart';
import '../components/profile_bottom.component.dart';
import '../constants/constant.dart';
import '../fragments/profile.fragemnt.dart';
import '../fragments/update.profile.dart';
import '../providers/user.provider.dart';
import 'home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../providers/profile.provider.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  late File? _pickedImage;
  String downloadURL = '';
  String hasImage = '';
  String? _gender;
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  int _index = 0;

  final List<Widget> _bodyPage = [
    const HomePage(),
    const SadaqahPage(),
    const HomePage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return SafeArea(
      child: Consumer<ProfileProvider>(builder: (context, data, child) {
        return Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: kSecondaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 20,
                          ),
                        )),
                    Container(
                        margin: const EdgeInsets.only(right: 15, bottom: 10),
                        width: 75,
                        height: 75,
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
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                locale.option_profile!,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              content: SingleChildScrollView(
                                                child: ListBody(
                                                  children: [
                                                    (_gender == "Male" ||
                                                            _gender == "Lelaki")
                                                        ? Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                5,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.2,
                                                            child: Column(
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
                                                                    children: <
                                                                        Widget>[
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          String d = await firebase_storage
                                                                              .FirebaseStorage
                                                                              .instance
                                                                              .ref('assets//avatar/male1.png')
                                                                              .getDownloadURL();
                                                                          await AppUser
                                                                              .instance
                                                                              .user!
                                                                              .updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/avatar/male1.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          String d = await firebase_storage
                                                                              .FirebaseStorage
                                                                              .instance
                                                                              .ref('assets//avatar/male2.png')
                                                                              .getDownloadURL();
                                                                          await AppUser
                                                                              .instance
                                                                              .user!
                                                                              .updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/avatar/male2.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          String d = await firebase_storage
                                                                              .FirebaseStorage
                                                                              .instance
                                                                              .ref('assets/avatar/male3.png')
                                                                              .getDownloadURL();
                                                                          await AppUser
                                                                              .instance
                                                                              .user!
                                                                              .updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/avatar/male3.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          String d = await firebase_storage
                                                                              .FirebaseStorage
                                                                              .instance
                                                                              .ref('assets/avatar/male4.png')
                                                                              .getDownloadURL();
                                                                          await AppUser
                                                                              .instance
                                                                              .user!
                                                                              .updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/avatar/male4.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          String d = await firebase_storage
                                                                              .FirebaseStorage
                                                                              .instance
                                                                              .ref('assets/avatar/male5.png')
                                                                              .getDownloadURL();
                                                                          await AppUser
                                                                              .instance
                                                                              .user!
                                                                              .updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/avatar/male5.png',
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
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                5,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.2,
                                                            child: Column(
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
                                                                    children: <
                                                                        Widget>[
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          String d = await firebase_storage
                                                                              .FirebaseStorage
                                                                              .instance
                                                                              .ref('/avatar/female1.png')
                                                                              .getDownloadURL();
                                                                          await AppUser
                                                                              .instance
                                                                              .user!
                                                                              .updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/avatar/female1.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          String d = await firebase_storage
                                                                              .FirebaseStorage
                                                                              .instance
                                                                              .ref('assets/avatar/female2.png')
                                                                              .getDownloadURL();
                                                                          await AppUser
                                                                              .instance
                                                                              .user!
                                                                              .updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/avatar/female2.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          String d = await firebase_storage
                                                                              .FirebaseStorage
                                                                              .instance
                                                                              .ref('assets/avatar/female3.png')
                                                                              .getDownloadURL();
                                                                          await AppUser
                                                                              .instance
                                                                              .user!
                                                                              .updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/avatar/female3.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          String d = await firebase_storage
                                                                              .FirebaseStorage
                                                                              .instance
                                                                              .ref('assets/avatar/female4.png')
                                                                              .getDownloadURL();
                                                                          await AppUser
                                                                              .instance
                                                                              .user!
                                                                              .updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/avatar/female4.png',
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      MaterialButton(
                                                                        onPressed:
                                                                            () async {
                                                                          String d = await firebase_storage
                                                                              .FirebaseStorage
                                                                              .instance
                                                                              .ref('assets/avatar/female5.png')
                                                                              .getDownloadURL();
                                                                          await AppUser
                                                                              .instance
                                                                              .user!
                                                                              .updatePhotoURL(d);
                                                                          await init();
                                                                          showTopSnackBar(
                                                                            context,
                                                                            CustomSnackBar.success(
                                                                              message: locale.success1!,
                                                                            ),
                                                                          );
                                                                          reloadPage();
                                                                        },
                                                                        child:
                                                                            Material(
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.0),
                                                                          color:
                                                                              Colors.white,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 5,
                                                                            child:
                                                                                Image.asset(
                                                                              'assets/avatar/female5.png',
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
                                                        Navigator.pop(context);
                                                      },
                                                      splashColor: Colors.blue,
                                                      child: Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Icon(
                                                              Icons.camera,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          Text(
                                                            locale
                                                                .camera_profile!,
                                                            style: const TextStyle(
                                                                fontSize: 18,
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
                                                        Navigator.pop(context);
                                                      },
                                                      splashColor: Colors.blue,
                                                      child: Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Icon(
                                                              Icons.image,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          Text(
                                                            locale
                                                                .gallery_profile!,
                                                            style: const TextStyle(
                                                                fontSize: 18,
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
                                                        Navigator.pop(context);
                                                      },
                                                      splashColor: Colors.blue,
                                                      child: Row(
                                                        children: [
                                                          const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Icon(
                                                              Icons
                                                                  .remove_circle,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          Text(
                                                            locale
                                                                .remove_profile!,
                                                            style: const TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    Colors.red),
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
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppUser.instance.user!.displayName ?? '',
                            style: textStyleBold),
                        Text(AppUser.instance.user!.email ?? '',
                            style: textStyleNormalGrey),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                dense: true,
                selectedColor: const Color(0xFFFFF461),
                hoverColor: const Color(0xFFFFF461),
                selectedTileColor: const Color(0xFFFFF461),
                leading: const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  locale.update_profile!,
                  style: textStyleNormal,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdateProfile()),
                  );
                },
              ),
              ListTile(
                dense: true,
                leading: const Icon(
                  Icons.info,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  locale.about!,
                  style: textStyleNormal,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutUsScreen()),
                  );
                },
              ),
              ListTile(
                dense: true,
                leading: const Icon(
                  Icons.handshake,
                  color: Colors.black,
                  size: 20,
                ),
                title: const Text(
                  'Acknowledgement',
                  style: textStyleNormal,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AcknowledgementScreen()),
                  );
                },
              ),
              ListTile(
                dense: true,
                leading: const Icon(
                  Icons.quiz,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  locale.helpdesk!,
                  style: textStyleNormal,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HelpDeskPage()),
                  );
                },
              ),
              ListTile(
                dense: true,
                leading: const Icon(
                  Icons.settings,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  locale.setting_profile!,
                  style: textStyleNormal,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingPage()),
                  );
                },
              ),
              ListTile(
                dense: true,
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 20,
                ),
                title: Text(
                  locale.logout!,
                  style: textStyleNormal,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(actions: [
                        ElevatedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent),
                            child: Text(locale.no!)),
                        ElevatedButton(
                            onPressed: () async {
                              await AppUser.instance.signOut();
                              Navigator.popAndPushNamed(context, 'login');
                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.green),
                            child: Text(locale.yes!)),
                      ], title: Text(locale.confirmToLogout!));
                    },
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }

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
