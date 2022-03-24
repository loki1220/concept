import 'package:concept/screens/feed_screen.dart';
import 'package:concept/screens/profile_screen.dart';
import 'package:concept/screens/search_screen.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  FeedScreen(),
  Search_screen(),
  Text("PPt"),
  Text("Notify"),
  Profile_Screen(),
];
