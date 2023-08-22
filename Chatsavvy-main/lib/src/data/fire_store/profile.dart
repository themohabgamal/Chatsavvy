import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pillwise/src/data/fire_store/fire_store_helper.dart';
import 'package:pillwise/src/models/my_user.dart';

Future<MyUser> retriveUserData() async {
  DocumentSnapshot<Map<String, dynamic>> doc = await FireStoreHelper()
      .getUserFromDB(FirebaseAuth.instance.currentUser!.uid);
  //get user data from db
  var docData = doc.data();
  // convert data json into our user class
  MyUser user = MyUser(
      id: docData!["id"],
      name: docData["name"],
      email: docData["email"],
      imageUrl: docData['image'],
      phone: docData['phone']);
  return user;
}
