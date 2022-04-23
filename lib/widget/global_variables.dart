import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concept/screens/feed_screen.dart';
import 'package:concept/screens/profile_screen.dart';
import 'package:concept/screens/search_screen.dart';
import 'package:concept/screens/slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../screens/settings_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  FeedScreen(),
  Search_screen(),
  Slideppt(),
  SettingsPage(),
  Profile_Screen(),
];


//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;
