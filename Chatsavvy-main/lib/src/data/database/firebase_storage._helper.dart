import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

class FirebaseStorageHelper {
  Future<String> storeFileToFirebase(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> addImageToDB(File? profilePic) async {
    String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child("images");
    Reference referenceImage = referenceDirImages.child(uniqueName);
    await referenceImage.putFile(profilePic!);
    String downloadUrl = await referenceImage.getDownloadURL();
    return downloadUrl;
  }
}
