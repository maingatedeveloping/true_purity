import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:overcome_lust/main.dart';
import 'package:overcome_lust/pages/about_us_page.dart';

import '../custom_theme/color_palette.dart';
import '../custom_theme/custom_button.dart';
import '../custom_theme/faq_tile.dart';
import '../helpers/row_column_switcher.dart';
import 'discussions_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? _hoveredItem;

  final List<Widget> pages = [
    const Home(),
    const DiscussionsPage(),
    AboutPage(),
    Center(
      child: Text('Profile'),
    )
  ];
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 720;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: ColorPalette.background,
      drawer: isMobile
          ? Drawer(
              backgroundColor: ColorPalette.background,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    color: ColorPalette.accent,
                    child: Center(
                      child: Text('True Purity',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        TabItem('Home', 0, screenWidth, scaffoldKey,
                            FontAwesomeIcons.house),
                        const SizedBox(height: 10),
                        TabItem('Discussions', 1, screenWidth, scaffoldKey,
                            FontAwesomeIcons.comment),
                        const SizedBox(height: 10),
                        TabItem('About', 2, screenWidth, scaffoldKey,
                            FontAwesomeIcons.circleInfo),
                        const SizedBox(height: 10),
                        TabItem('Profile', 3, screenWidth, scaffoldKey,
                            FontAwesomeIcons.user),
                        SizedBox(height: 15),
                        Divider(
                          color: Colors.white,
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                            const SizedBox(width: 20),
                            CustomButton(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 7,
                                ),
                                text: "Log In",
                                color: Colors.black,
                                onPressed: () {
                                  context.go('/sign_in');
                                }),
                          ],
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
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )
          : null,
      body: Center(
        child: isMobile
            ? pages[selectedPage]
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                constraints: BoxConstraints(
                    maxWidth: screenWidth * 0.8, maxHeight: screenHeight * 0.9),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.black),
                  //color: ColorPalette.secondary,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.17,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TabItem('Home', 0, screenWidth, scaffoldKey,
                              FontAwesomeIcons.house),
                          const SizedBox(height: 10),
                          TabItem('Discussions', 1, screenWidth, scaffoldKey,
                              FontAwesomeIcons.comment),
                          const SizedBox(height: 10),
                          TabItem('About', 2, screenWidth, scaffoldKey,
                              FontAwesomeIcons.circleInfo),
                          const SizedBox(height: 10),
                          TabItem('Profile', 3, screenWidth, scaffoldKey,
                              FontAwesomeIcons.user),
                          SizedBox(height: 15),
                          Divider(
                            color: Colors.white,
                          ),
                          SizedBox(height: 15),
                          Column(
                            children: [
                              CustomButton(
                                  text: "Sign Up",
                                  color: Colors.black,
                                  onPressed: () {
                                    context.go('/sign_up');
                                  }),
                              const SizedBox(height: 10),
                              CustomButton(
                                  text: "Log In",
                                  color: Colors.black,
                                  onPressed: () {
                                    context.go('/sign_in');
                                  }),
                            ],
                          ),
                        ],
                      ),
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
  }

  // ignore: non_constant_identifier_names
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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 720;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: ColorPalette.background,
        ),
        constraints: isMobile
            ? null
            : BoxConstraints(maxWidth: (screenWidth * 0.63) - 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Struggling with lust?',
              style: TextStyle(
                fontSize: isMobile ? 30 : 38,
                fontWeight: FontWeight.bold,
                //  fontStyle: FontStyle.italic,
                color: Colors.blueAccent,
              ),
            ),
            Text(
              'Empowering you to overcome lust, embrace self-control, and build a life of purpose and purity.',
              softWrap: true,
              style: TextStyle(
                fontSize: isMobile ? 19 : 22,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.clip,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: isMobile ? null : screenWidth * 0.63 - 60,
              height: isMobile ? null : screenHeight * 0.7,
              child: Image.asset(
                'assets/images/frustrated-african-businessman-feeling-exhausted-600nw-1044298774.webp',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Lust is a powerful, intense desire often driven by physical attraction. While natural, it can sometimes lead to unhealthy behaviors if it becomes an obsession or interferes with personal well-being and relationships. Overcoming excessive lust can help individuals find more meaningful connections and achieve emotional balance.',
              style: TextStyle(fontSize: 19),
            ),
            const SizedBox(height: 30),
            isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        // width: screenWidth * 0.25,
                        child: const Text(
                          "We help you overcome pornography, masturbation, and related behaviors, empowering you to lead a healthier, more fulfilling life. If lust is affecting your thoughts or actions, reaching out for support can help you regain control. Contact us for personalized guidance and a path to lasting change.",
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                      SizedBox(
                        // width: screenWidth * 0.26,
                        height: screenHeight * 0.4,
                        child: Image.asset(
                          'assets/images/images.jpeg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: screenWidth * 0.25,
                        child: const Text(
                          "We help you overcome pornography, masturbation, and related behaviors, empowering you to lead a healthier, more fulfilling life. If lust is affecting your thoughts or actions, reaching out for support can help you regain control. Contact us for personalized guidance and a path to lasting change.",
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.26,
                        height: screenHeight * 0.4,
                        child: Image.asset(
                          'assets/images/images.jpeg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
            const SizedBox(height: 30),
            RowColumnSwitcher(
              children: [
                Text(
                  'Contact us',
                  style: TextStyle(
                      fontSize: isMobile ? 28 : 35,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        'WhatsApp: +233 591553347',
                        style: TextStyle(fontSize: isMobile ? 17 : 20),
                      ),
                      SizedBox(height: 15),
                      SelectableText(
                        'Phone Number: +233 591553347',
                        style: TextStyle(fontSize: isMobile ? 17 : 20),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.white),
            const SizedBox(height: 20),
            const Text(
              'Frequently asked questions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const FaqTile(
                question: 'question', answer: 'there  would be an answer'),
            const SizedBox(height: 10),
            const FaqTile(
                question: 'question', answer: 'there  would be an answer'),
            const SizedBox(height: 10),
            const FaqTile(
                question: 'question', answer: 'there  would be an answer'),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(
                    text: "Sign Up",
                    color: Colors.black,
                    onPressed: () {
                      context.go('/sign_up');
                    }),
                const SizedBox(width: 20),
                CustomButton(
                    text: "Log In",
                    color: Colors.black,
                    onPressed: () {
                      context.go('/sign_in');
                    }),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
