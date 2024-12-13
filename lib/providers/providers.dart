import 'package:flutter/material.dart';

class GlobalState with ChangeNotifier {
  final int _selectedPage = 0;
  String? _hoveredItem;

  int get selectedPage => _selectedPage;
  String? get hoveredItem => _hoveredItem;
}
