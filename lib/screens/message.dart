import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { Text, Image }

class Message {
  String? senderID;
  String? content;
  MessageType? messageType;
  Timestamp? sentAt;

  Message({
    required this.senderID,
    required this.content,
    required this.messageType,
    required this.sentAt,
  });

  Message.fromJson(Map<String, dynamic> json) {
    senderID = json['senderID'];
    content = json['content'];
    sentAt = json['sentAt'];
    messageType = MessageType.values.byName(json['messageType']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['senderID'] = senderID;
    data['content'] = content;
    data['sentAt'] = sentAt;
    data['messageType'] = messageType!.name;
    return data;
  }
}
class UserProfile {
  final String uid;
  final String? displayName;
  final String? email;
  final String? photoURL;

  UserProfile({
    required this.uid,
    this.displayName,
    this.email,
    this.photoURL,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid'],
      displayName: json['name'],
      email: json['email'],
      photoURL: json['profile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': displayName,
      'email': email,
      'profile': photoURL,
    };
  }
}
