import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pillwise/src/models/my_message.dart';
import 'package:pillwise/src/models/my_room.dart';
import 'package:pillwise/src/models/my_user.dart';

class FireStoreHelper {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  addUserToDB(MyUser user) async {
    return await firebaseFirestore.collection("users").doc(user.id).set({
      'name': user.name,
      'email': user.email,
      'id': user.id,
      'image': user.image,
      'phone': user.phone
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserFromDB(
      String id) async {
    return await firebaseFirestore.collection("users").doc(id).get();
  }

  CollectionReference<MyRoom> getRoomsCollection() {
    return FirebaseFirestore.instance.collection("rooms").withConverter(
        fromFirestore: (snapshot, options) => MyRoom.fromMap(snapshot.data()!),
        toFirestore: (room, options) => room.toMap());
  }

  CollectionReference<MyMessage> getMessagesCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomId)
        .collection("messages")
        .withConverter(
          fromFirestore: (snapshot, options) =>
              MyMessage.fromMap(snapshot.data()!),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  Future<void> createNewRoomToFireStore(MyRoom room) {
    var doc = getRoomsCollection().doc();
    room.roomId = doc.id;
    return doc.set(room);
  }

  Stream<QuerySnapshot<MyRoom>> getRoomsList() {
    return getRoomsCollection().snapshots();
  }

  Stream<QuerySnapshot<MyMessage>> getMessagesList(String roomId) {
    return getMessagesCollection(roomId).orderBy("dateTime").snapshots();
  }

  Future addMessageToFireStore(MyMessage message) {
    var doc = getMessagesCollection(message.roomId).doc();
    message.messageId = doc.id;
    return doc.set(message);
  }

  Future deleteMessageToFireStore(MyMessage message) {
    var doc = getMessagesCollection(message.roomId).doc();

    return doc.delete();
  }

  Future<void> updateUserInfo(MyUser user) async {
    await firebaseFirestore
        .collection("users")
        .doc(user.id)
        .update(user.toMap());
  }
}
