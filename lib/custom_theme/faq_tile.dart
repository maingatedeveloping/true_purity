import 'package:flutter/material.dart';

class FaqTile extends StatefulWidget {
  const FaqTile({super.key, required this.question, required this.answer});

  final String question;
  final String answer;
  @override
  State<FaqTile> createState() => _FaqTileState();
}

class _FaqTileState extends State<FaqTile> {
  bool _isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: _isOpen ? 0 : 2,
      shadowColor: Colors.grey[100],
      child: ExpansionTile(
        collapsedShape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        shape: LinearBorder.none,
        onExpansionChanged: (value) {
          setState(() {
            _isOpen = value;
          });
        },
        maintainState: true,
        collapsedBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        title: Text(
          widget.question,
        ),
        trailing: Icon(
          _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
        ),
        children: [
          Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16,
              ),
              child: Text(widget.answer),
            ),
          )
        ],
      ),
    );
  }
}
