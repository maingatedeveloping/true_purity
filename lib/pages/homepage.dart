import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:true_purity/pages/about_us_page.dart';
import 'package:true_purity/pages/user_profile_page.dart';

import '../custom_theme/color_palette.dart';
import '../custom_theme/custom_button.dart';
import 'discussions_page.dart';
import 'homepage_content.dart';
import 'users_page.dart';

int selectedPage = 0;
String? _hoveredItem;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAdmin = false;

  final List<Widget> pages = [
    const HomePageContent(),
    const DiscussionsPage(),
    AboutPage(),
    UsersPage(),
    Center(
      child: Text('Profile'),
    )
  ];

  Future<void> logOut(BuildContext context, bool isMobile) async {
    try {
      await FirebaseAuth.instance.signOut();
      isMobile ? scaffoldKey.currentState!.closeDrawer() : null;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out')),
      );
    }
  }

  fetchStatus() async {
    try {
      final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        setState(() {
          isAdmin = snapshot.data()?['is_admin'] ?? false;
        });
      } else {
        debugPrint('User document not found');
        setState(() {
          isAdmin = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching user status: $e');
      setState(() {
        isAdmin = false;
      });
    }
  }

  @override
  void initState() {
    fetchStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 720;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          bool isUserPresent = snapshot.data != null;
          return Scaffold(
            key: scaffoldKey,
            backgroundColor: ColorPalette.background,
            drawer: isMobile
                ? Drawer(
                    backgroundColor: ColorPalette.background,
                    child: Column(
                      children: [
                        if (isUserPresent)
                          UserProfile(scaffoldKey: scaffoldKey),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 10,
                                  right: 20,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (isUserPresent)
                                      Divider(color: ColorPalette.secondary),
                                    SizedBox(height: 20),
                                    TabItem('Home', 0, screenWidth, scaffoldKey,
                                        FontAwesomeIcons.house),
                                    const SizedBox(height: 10),
                                    TabItem('Discussions', 1, screenWidth,
                                        scaffoldKey, FontAwesomeIcons.comment),
                                    const SizedBox(height: 10),
                                    TabItem(
                                        'About',
                                        2,
                                        screenWidth,
                                        scaffoldKey,
                                        FontAwesomeIcons.circleInfo),
                                    if (isUserPresent && isAdmin)
                                      const SizedBox(height: 10),
                                    if (isUserPresent && isAdmin)
                                      TabItem('Users', 3, screenWidth,
                                          scaffoldKey, FontAwesomeIcons.users),
                                    if (isUserPresent)
                                      const SizedBox(height: 10),
                                    Divider(color: Colors.white),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: isUserPresent
                                          ? MainAxisAlignment.center
                                          : MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (!isUserPresent)
                                          CustomButton(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 7,
                                              ),
                                              text: "Sign Up",
                                              color: Colors.black,
                                              onPressed: () {
                                                context.go('/sign_up');
                                              }),
                                        if (!isUserPresent)
                                          const SizedBox(width: 20),
                                        if (!isUserPresent)
                                          CustomButton(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 7,
                                              ),
                                              text: "Sign In",
                                              color: Colors.black,
                                              onPressed: () {
                                                context.go('/sign_in');
                                              }),
                                        if (isUserPresent)
                                          CustomButton(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 6,
                                              ),
                                              text: 'Sign Out',
                                              color: Colors.black,
                                              onPressed: () {
                                                logOut(context, isMobile);
                                              }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : null,
            appBar: isMobile
                ? AppBar(
                    backgroundColor: ColorPalette.accent,
                    centerTitle: true,
                    title: Text(
                      'True Purity',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  )
                : null,
            body: Center(
              child: isMobile
                  ? pages[selectedPage]
                  : Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 0, bottom: 20),
                      constraints: BoxConstraints(
                          maxWidth: screenWidth * 0.8,
                          maxHeight: screenHeight * 0.9),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              if (isUserPresent)
                                UserProfile(
                                  constraints: BoxConstraints(
                                      maxWidth: screenWidth * 0.17),
                                  imagesSize: 75,
                                ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: SizedBox(
                                    width: screenWidth * 0.17,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (isUserPresent)
                                          Divider(
                                              color: ColorPalette.secondary),
                                        SizedBox(height: 20),
                                        TabItem(
                                          'Home',
                                          0,
                                          screenWidth,
                                          scaffoldKey,
                                          FontAwesomeIcons.house,
                                        ),
                                        const SizedBox(height: 10),
                                        TabItem(
                                          'Discussions',
                                          1,
                                          screenWidth,
                                          scaffoldKey,
                                          FontAwesomeIcons.comment,
                                        ),
                                        const SizedBox(height: 10),
                                        TabItem(
                                            'About',
                                            2,
                                            screenWidth,
                                            scaffoldKey,
                                            FontAwesomeIcons.circleInfo),
                                        if (isUserPresent && isAdmin)
                                          const SizedBox(height: 10),
                                        if (isUserPresent && isAdmin)
                                          TabItem(
                                              'Users',
                                              3,
                                              screenWidth,
                                              scaffoldKey,
                                              FontAwesomeIcons.users),
                                        SizedBox(height: 15),
                                        Divider(
                                          color: Colors.white,
                                        ),
                                        SizedBox(height: 15),
                                        Column(
                                          children: [
                                            if (!isUserPresent)
                                              CustomButton(
                                                  text: "Sign Up",
                                                  color: Colors.black,
                                                  onPressed: () {
                                                    context.go('/sign_up');
                                                  }),
                                            const SizedBox(height: 10),
                                            CustomButton(
                                                text: !isUserPresent
                                                    ? 'Sign In'
                                                    : "Sign Out",
                                                color: Colors.black,
                                                onPressed: () {
                                                  isUserPresent
                                                      ? logOut(
                                                          context, isMobile)
                                                      : context.go('/sign_in');
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            height: screenHeight * 0.9 - 40,
                            child: const VerticalDivider(color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          pages[selectedPage],
                        ],
                      ),
                    ),
            ),
          );
        });
  }

  Widget TabItem(String title, int index, double screenWidth,
      GlobalKey<ScaffoldState> scaffoldKey, IconData? icon) {
    final bool isMobile = MediaQuery.of(context).size.width < 720;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPage = index;
        });
        scaffoldKey.currentState!.isDrawerOpen
            ? scaffoldKey.currentState!.closeDrawer()
            : scaffoldKey.currentState!.openDrawer();
      },
      child: MouseRegion(
        onEnter: (_) {
          setState(() {
            _hoveredItem = title;
          });
        },
        onExit: (_) {
          setState(() {
            _hoveredItem = null;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:
                _hoveredItem == title ? ColorPalette.accent : Colors.lightBlue,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: screenWidth < 720
                ? null
                : selectedPage == index
                    ? Border.all(color: Colors.black, width: 1)
                    : null,
          ),
          child: Row(
            children: [
              SizedBox(
                width: isMobile
                    ? 10
                    : screenWidth > 1000
                        ? 20
                        : null,
              ),
              Row(
                children: [
                  Icon(
                    icon,
                    size: 15,
                  ),
                  SizedBox(width: screenWidth < 1000 ? 10 : 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
