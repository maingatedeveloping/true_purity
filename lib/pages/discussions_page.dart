import 'package:flutter/material.dart';

class DiscussionsPage extends StatefulWidget {
  const DiscussionsPage({super.key});

  @override
  State<DiscussionsPage> createState() => _DiscussionsPageState();
}

class _DiscussionsPageState extends State<DiscussionsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = MediaQuery.of(context).size.height < 720;

    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          constraints: isMobile
              ? null
              : BoxConstraints(maxWidth: (screenWidth * 0.63) - 60),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MessageBubble(text: 'Hi'),
              MessageBubble(text: 'Sup'),
              MessageBubble(text: 'How is it going'),
              MessageBubble(text: 'cool'),
              MessageBubble(text: 'Hi'),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;

  const MessageBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12), // Border radius for round edges
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 16,
              color: Colors.black), // Text style inside the bubble
        ),
      ),
    );
  }
}
