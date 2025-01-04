import 'package:chat_app/components/my_chat_bubble.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  ChatPage({super.key, required this.receiverEmail, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // create the messages controller
  final TextEditingController _messageController = TextEditingController();

  // get Services
  final AuthService _authService = AuthService();
  final ChatServices _chatServices = ChatServices();

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 1000),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 800),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    focusNode.dispose();
    _messageController.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  // create the message sending fn
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatServices.sendMessage(
          widget.receiverId, _messageController.text);
      _messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.receiverEmail,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(child: _messageList()),
          // user input
          _userInput()
        ],
      ),
    );
  }

  Widget _messageList() {
    String userId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatServices.getMessages(userId, widget.receiverId),
        builder: (contex, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An Error occured'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
              controller: _scrollController,
              children:
                  snapshot.data!.docs.map((doc) => _messageItem(doc)).toList());
        });
  }

  Widget _messageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user

    bool iscurrentuser = data['senderId'] == _authService.getCurrentUser()!.uid;
    return Container(
        child: Column(
      crossAxisAlignment:
          iscurrentuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        MyChatBubble(message: data['message'], isCurrentUser: iscurrentuser),
      ],
    ));
  }

  Widget _userInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              hintText: 'Type a message',
              isObscure: false,
              controller: _messageController,
              focusNode: focusNode,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 25),
            decoration: const BoxDecoration(
                color: Colors.green, shape: BoxShape.circle),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
