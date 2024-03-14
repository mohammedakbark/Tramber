import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tramber/Model/user_model.dart';
import 'package:tramber/utils/variables.dart';

File? imageFileProfile;
File? imageFileProof;
File? imageFilePlace;

final db = FirebaseFirestore.instance;
final firbaseStorage = FirebaseStorage.instance;

///////////////////////////////////////////////////////////////
Future<void> selectImage(context, int selected) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  DocumentReference docUpdateRef = db.collection('user').doc(currentUID);
  DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await db.collection("user").doc(currentUID).get();
  SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');

  if (pickedFile != null) {
    if (selected == 1) {
      imageFileProfile = File(pickedFile.path);

      UploadTask uploadTask = firbaseStorage
          .ref()
          .child("userimage/$currentUID")
          .putFile(imageFileProfile!, metadata);
      TaskSnapshot snapshot = await uploadTask;

      String downloadURL = await snapshot.ref.getDownloadURL();

      docUpdateRef.update({"profileimage": downloadURL});

      storenstence.userModel = UserModel.fromJson(userSnapshot.data()!);
    } else if (selected == 2) {
      imageFileProof = File(pickedFile.path);
      UploadTask uploadTask = firbaseStorage
          .ref()
          .child("userProof/$currentUID")
          .putFile(imageFileProof!, metadata);
      TaskSnapshot snapshot = await uploadTask;

      String downloadURL = await snapshot.ref.getDownloadURL();

      docUpdateRef.update({"proofimage": downloadURL});
      storenstence.userModel = UserModel.fromJson(userSnapshot.data()!);
    }
  }
}

Future addPlaceImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
  if (pickedFile != null) {
    final currenttime = TimeOfDay.now();
    imageFilePlace = File(pickedFile.path);
    UploadTask uploadTask = firbaseStorage
        .ref()
        .child("placeImage/Admin$currenttime")
        .putFile(imageFilePlace!, metadata);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
    // final doc = db.collection("placeimage").doc();

    // next add image to firestore
  }

 
}
 Future addHotelImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    if (pickedFile != null) {
      final currenttime = TimeOfDay.now();
      imageFilePlace = File(pickedFile.path);
      UploadTask uploadTask = firbaseStorage
          .ref()
          .child("HotelImage/Admin$currenttime")
          .putFile(imageFilePlace!, metadata);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
      // final doc = db.collection("placeimage").doc();

      // next add image to firestore
    }
  }
  Future addRestaurentImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    if (pickedFile != null) {
      final currenttime = TimeOfDay.now();
      imageFilePlace = File(pickedFile.path);
      UploadTask uploadTask = firbaseStorage
          .ref()
          .child("RestaurentImage/Admin$currenttime")
          .putFile(imageFilePlace!, metadata);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
      // final doc = db.collection("placeimage").doc();

      // next add image to firestore
    }
  }