import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:ecommerce_app/services/mediaservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/services/firebase.dart';
import 'package:ecommerce_app/screens/chat.dart';
import 'package:ecommerce_app/screens/message.dart';

class ChatUI extends StatefulWidget {
  final UserProfile chatUser;
  const ChatUI({super.key, required this.chatUser});

  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  ChatUser? currentUser, otherUser;
  MediaService mediaservice = MediaService();
  FirebaseServices service = FirebaseServices();
  User? cuUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = ChatUser(id: cuUser!.uid, firstName: cuUser!.displayName);
    otherUser = ChatUser(
      id: widget.chatUser.uid,
      firstName: widget.chatUser.displayName,
      profileImage: widget.chatUser.photoURL,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatUser.displayName!),
      ),
      body: _buildUi(),
    );
  }

  Widget _buildUi() {
    return StreamBuilder<DocumentSnapshot<Chat>>(
      stream: service.getChatData(currentUser!.id, otherUser!.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        Chat? chat = snapshot.data?.data();
        List<ChatMessage> messages = chat != null && chat.messages != null
            ? generateChatMessageList(chat.messages!)
            : [];

        return DashChat(
          messageOptions: const MessageOptions(
            showOtherUsersAvatar: true,
            showTime: true,
          ),
          inputOptions: InputOptions(alwaysShowSend: true, trailing: [
            _mediaMessageButton(),
          ]),
          currentUser: currentUser!,
          onSend: sendMessage,
          messages: messages,
        );
      },
    );
  }

  Future<void> sendMessage(ChatMessage chatMessage) async {
    Message message;

    if (chatMessage.medias != null &&
        chatMessage.medias!.isNotEmpty &&
        chatMessage.medias!.first.type == MediaType.image) {
      // Sending an image message
      message = Message(
        senderID: currentUser!.id,
        content: chatMessage.medias!.first.url,
        messageType: MessageType.Image,
        sentAt: Timestamp.fromDate(chatMessage.createdAt),
      );
    } else {
      // Sending a text message
      message = Message(
        senderID: currentUser!.id,
        content: chatMessage.text, // Provide a default value for text if null
        messageType: MessageType.Text,
        sentAt: Timestamp.fromDate(chatMessage.createdAt),
      );
    }

    try {
      await service.sendChatMessage(currentUser!.id, otherUser!.id, message);
    } catch (e) {
      print('Error sending message: $e');
      // Handle error gracefully
    }
  }

  List<ChatMessage> generateChatMessageList(List<Message> messages) {
    List<ChatMessage> chatMessages = messages.map((m) {
      if (m.messageType == MessageType.Image) {
        return ChatMessage(
          user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
          medias: [
            ChatMedia(url: m.content!, fileName: "", type: MediaType.image)
          ],
          createdAt: m.sentAt!.toDate(),
        );
      } else {
        return ChatMessage(
          user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
          text: m.content ?? '',
          createdAt: m.sentAt!.toDate(),
        );
      }
    }).toList();

    chatMessages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return chatMessages;
  }

  Widget _mediaMessageButton() {
    return IconButton(
      onPressed: () async {
        File? file = await mediaservice.getImageFromGallery();
        if (file != null) {
          String chatId = service.generateChatId(
              uid1: currentUser!.id, uid2: otherUser!.id);
          String? downloadUrl =
              await service.uploadImageToChat(file: file, chatId: chatId);

          if (downloadUrl != null) {
            ChatMessage chatMessage = ChatMessage(
              user: currentUser!,
              createdAt: DateTime.now(),
              medias: [
                ChatMedia(url: downloadUrl, fileName: "", type: MediaType.image)
              ],
            );
            sendMessage(chatMessage);
          }
        }
      },
      icon: const Icon(Icons.image),
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
