import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../custom_theme/color_palette.dart';
import '../custom_theme/custom_button.dart';
import '../custom_theme/faq_tile.dart';
import '../helpers/row_column_switcher.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;

    bool isMobile = MediaQuery.of(context).size.width < 720;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: StreamBuilder(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            bool isUserPresent = snapshot.data != null;
            return Container(
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
                              'WhatsApp: +233 599347306',
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
                      question:
                          'What tools or resources does this website provide?',
                      answer:
                          'We provide tools like online support communities, and professional guidance. These resources help you stay focused on your goals and overcome challenges effectively.'),
                  const SizedBox(height: 10),
                  const FaqTile(
                      question: 'Why should I quit porn and masturbation?',
                      answer:
                          'Quitting these habits can lead to improved mental clarity, better self-esteem, enhanced relationships, and increased productivity. Overuse of pornography can negatively affect dopamine regulation, which impacts motivation and mood. Eliminating these habits helps regain control over your life and improves your overall well-being.'),
                  const SizedBox(height: 10),
                  const FaqTile(
                      question:
                          'How much do i get to pay as a regiteration fee?',
                      answer: '50 Cedis'),
                  const SizedBox(height: 30),
                  if (!isUserPresent)
                    Row(
                      mainAxisAlignment: isMobile
                          ? MainAxisAlignment.spaceAround
                          : MainAxisAlignment.end,
                      children: [
                        CustomButton(
                            padding: isMobile
                                ? EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 6)
                                : null,
                            text: "Sign Up",
                            color: Colors.black,
                            onPressed: () {
                              context.go('/sign_up');
                            }),
                        const SizedBox(width: 20),
                        CustomButton(
                            padding: isMobile
                                ? EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 6)
                                : null,
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
            );
          }),
    );
  }
}
