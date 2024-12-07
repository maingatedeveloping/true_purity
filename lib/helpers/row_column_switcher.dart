import 'package:flutter/material.dart';

class RowColumnSwitcher extends StatefulWidget {
  const RowColumnSwitcher({super.key, required this.children});

  final List<Widget> children;
  @override
  State<RowColumnSwitcher> createState() => _RowColumnSwitcherState();
}

class _RowColumnSwitcherState extends State<RowColumnSwitcher> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 1000
        ? Column(
            // direction: Axis.vertical,
            // alignment: WrapAlignment.spaceBetween,
            // runAlignment: WrapAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.children,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.children,
          );
  }
}
