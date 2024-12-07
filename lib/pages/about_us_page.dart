import 'package:flutter/material.dart';

import '../helpers/row_column_switcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 720;
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        constraints: isMobile
            ? null
            : BoxConstraints(maxWidth: (screenWidth * 0.63) - 60),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              "Welcome to True Purity",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),

            // Mission Statement
            Text(
              "Our Mission",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "At True Purity, our mission is simple: to help you overcome lust completely by providing you with the right guidance, resources, and support. We understand that the journey can be challenging, but you don’t have to go through it alone. Our approach combines personalized conversations, expert advice, and a supportive community to help you regain control of your thoughts and actions.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 15),

            // How We Help
            Text(
              "How We Help",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "We believe that overcoming lust isn’t just about willpower—it’s about understanding, education, and positive change. That’s why we offer:",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text(
                "One-on-One Conversations: Through open and honest discussions, we help you address the root causes of lust and create strategies to overcome it.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text(
                "Educational Resources: We provide the necessary information and tools to empower you to make informed decisions and develop healthier habits.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text(
                "Ongoing Support: You’ll never feel alone on this journey. Our team is here to guide and encourage you every step of the way.",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            SizedBox(height: 15),

            // Offer Section
            Text(
              "What We Offer",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "When you begin your journey with us, you'll enjoy a full week of access to our resources for just 50 cedis as a registration fee. This gives you the time and space you need to start your transformation and take the first step toward a healthier, more fulfilling life.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 15),

            // Why Choose Us
            Text(
              "Why Choose Us?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "• Empathy and Understanding: We know how difficult it can be to overcome these challenges. Our team is dedicated to providing a safe, non-judgmental space where you can freely discuss your struggles.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            Text(
              "• Confidentiality: Your privacy is our priority. All conversations and information shared are completely confidential.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            Text(
              "• Expert Guidance: Our team of trained professionals will help guide you with the best practices and strategies to break free from lust and live a more focused and purposeful life.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 15),

            // Vision Section
            Text(
              "Our Vision",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "We envision a world where individuals are empowered to live free from the chains of lust, with a renewed sense of purpose and self-control. Our goal is to create a supportive, non-judgmental space where anyone can seek help, learn, and grow.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 15),

            // Call to Action
            Text(
              "Take the First Step",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "If you're ready to start your journey toward freedom, [Your Website Name] is here to help. Register today, and let’s begin this transformative journey together.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            RowColumnSwitcher(
              children: [
                const Text(
                  'Contact us',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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

            // // CTA Button
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Handle the registration logic or link to the registration page
            //     },
            //     style: ElevatedButton.styleFrom(
            //       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     child: Text(
            //       "Start Today",
            //       style: TextStyle(fontSize: 18),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
