// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/chat.dart';
import 'package:ecommerce_app/screens/message.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class FirebaseServices {
  final FirebaseStorage _firebaseStorage;
  final CollectionReference<Chat> chatsCollection;
  final CollectionReference<UserProfile> usersCollection;

  FirebaseServices({FirebaseStorage? firebaseStorage})
      : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance,
        chatsCollection = FirebaseFirestore.instance.collection('chats').withConverter<Chat>(
          fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
          toFirestore: (chat, _) => chat.toJson(),
        ),
        usersCollection = FirebaseFirestore.instance.collection('users').withConverter<UserProfile>(
          fromFirestore: (snapshot, _) => UserProfile.fromJson(snapshot.data()!),
          toFirestore: (userprofile, _) => userprofile.toJson(),
        );

  Stream<DocumentSnapshot<Chat>> getChatData(String uid1, String uid2) {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);
    return chatsCollection.doc(chatId).snapshots();
  }

  Future<void> createUserProfile({required UserProfile userprofile}) async {
    await usersCollection.doc(userprofile.uid).set(userprofile);
  }

  Stream<QuerySnapshot<UserProfile>> getUsersProfiles(String currentUserUid) {
    return usersCollection.where('uid', isNotEqualTo: currentUserUid).snapshots();
  }

  String generateChatId({required String uid1, required String uid2}) {
    List<String> uids = [uid1, uid2];
    uids.sort();
    return uids.join('_');
  }

  Future<bool> checkChatExists(String uid1, String uid2) async {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);
    final result = await chatsCollection.doc(chatId).get();
    return result.exists;
  }

  Future<void> createNewChat(String uid1, String uid2) async {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);
    final chat = Chat(id: chatId, participants: [uid1, uid2], messages: []);
    await chatsCollection.doc(chatId).set(chat);
  }

  Future<void> sendChatMessage(String uid1, String uid2, Message message) async {
    String chatId = generateChatId(uid1: uid1, uid2: uid2);
    await chatsCollection.doc(chatId).update({
      "messages": FieldValue.arrayUnion([message.toJson()])
    });
  }

  Future<String?> uploadImageToChat({required File file, required String chatId}) async {
    try {
      Reference fileRef = _firebaseStorage
          .ref('chats/$chatId')
          .child('${DateTime.now().toIso8601String()}${p.extension(file.path)}');

      UploadTask task = fileRef.putFile(file);
      TaskSnapshot snapshot = await task;
      if (snapshot.state == TaskState.success) {
        return await fileRef.getDownloadURL();
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
