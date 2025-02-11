import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'controller/auth_controller.dart';

// List pages = [
//   VideoScreen(),
//   SearchScreen(),
//   const AddVideoScreen(),
//   Text('Messages Screen'),
//   ProfileScreen(uid: authController.user.uid),
// ];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
// var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// // CONTROLLER
//  var authController = AuthController.instance;