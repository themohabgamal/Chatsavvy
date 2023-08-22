import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pillwise/src/data/fire_store/fire_store_helper.dart';
import 'package:pillwise/src/models/my_message.dart';
import 'package:pillwise/src/models/my_room.dart';
import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/res/text_style.dart';
import 'package:pillwise/src/shared/widgets/chat_message.dart';
import 'package:pillwise/src/views/chat/chat_view_model.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = 'chat';

  const ChatScreen({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController scrollController = ScrollController();
  @override
  String? name;
  ChatViewModel chatViewModel = ChatViewModel();
  @override
  void initState() {
    super.initState();
    _goToBottomPage();
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as MyRoom;
    chatViewModel.roomId = room.roomId;
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          room.name,
          style: bodyText3,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(
            height: 2,
            thickness: 3,
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot<MyMessage>>(
            stream: FireStoreHelper().getMessagesList(chatViewModel.roomId),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error : ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                List<MyMessage> messageList =
                    snapshot.data!.docs.map((doc) => doc.data()).toList();
                List<MyMessage> reversedList = List.from(messageList.reversed);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    itemCount: reversedList.length,
                    itemBuilder: (context, index) {
                      return ChatMessage(message: reversedList[index]);
                    },
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      onChanged: (value) {
                        chatViewModel.content = value;
                      },
                      style: const TextStyle(color: Colors.black),
                      controller: chatViewModel.textController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.attach_file,
                              size: 30,
                            )),
                        prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.emoji_emotions,
                              size: 30,
                            )),
                        filled: true,
                        hintText: 'Enter a message',
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await chatViewModel.sendMessage();
                    scrollController
                        .jumpTo(scrollController.position.minScrollExtent);
                  },
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: primaryColor,
                    child: Icon(
                      Icons.send,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _goToBottomPage() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      print("scrolled");
    });
  }
}
