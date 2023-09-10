import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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
  String? imageUrl;
  bool isRecorderInit = false;
  bool isRecording = false;
  FlutterSoundRecorder? _soundRecorder;
  ChatViewModel chatViewModel = ChatViewModel();
  @override
  void initState() {
    super.initState();
    _soundRecorder = FlutterSoundRecorder();
    openAudio();
  }

  @override
  void dispose() {
    super.dispose();
    _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("Mic is not granted");
    }
    await _soundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)!.settings.arguments as MyRoom;
    chatViewModel.roomId = room.roomId;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.black,
          elevation: 0,
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                radius: 24,
                child: Text(
                  room.name[0],
                  style: bodyText3.copyWith(
                      fontSize: 27,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                room.name,
                style: bodyText3.copyWith(fontSize: 24),
              ),
            ],
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: const [
                SizedBox(
                  height: 10,
                  width: double.infinity,
                ),
              ],
            ),
            Positioned(
                top: 20,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Column(
                    children: [
                      const Divider(
                        height: 2,
                        thickness: 3,
                      ),
                      Expanded(
                          child: StreamBuilder<QuerySnapshot<MyMessage>>(
                        stream: FireStoreHelper()
                            .getMessagesList(chatViewModel.roomId),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error : ${snapshot.error}"),
                            );
                          } else if (snapshot.hasData) {
                            List<MyMessage> messageList = snapshot.data!.docs
                                .map((doc) => doc.data())
                                .toList();
                            List<MyMessage> reversedMessages =
                                messageList.reversed.toList();
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                controller: scrollController,
                                reverse: true,
                                itemCount: reversedMessages.length,
                                itemBuilder: (context, index) {
                                  return ChatMessage(
                                    message: reversedMessages[index],
                                  );
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
                    ],
                  ),
                ))
          ],
        ),
        bottomNavigationBar: Container(
          height: 80,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    onChanged: (value) {
                      chatViewModel.content = value;
                    },
                    style: bodyText2.copyWith(color: Colors.black),
                    controller: chatViewModel.textController,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        prefixIcon: GestureDetector(
                          onTap: () async {
                            if (!isRecorderInit) {
                              print("is init : $isRecorderInit");
                              return;
                            }

                            var tempDir = await getTemporaryDirectory();
                            var path = "${tempDir.path}/flutter_sound.aac";
                            if (isRecording) {
                              await _soundRecorder!.stopRecorder();
                              String uniqueName =
                                  "${DateTime.now().millisecondsSinceEpoch.toString()}.aac";
                              Reference referenceRoot =
                                  FirebaseStorage.instance.ref();
                              Reference referenceDirImages =
                                  referenceRoot.child("voice_messages");
                              Reference referenceImage =
                                  referenceDirImages.child(uniqueName);
                              await referenceImage.putFile(File(path));
                              String downloadUrl =
                                  await referenceImage.getDownloadURL();
                              print(downloadUrl);
                            } else {
                              await _soundRecorder!.startRecorder(toFile: path);
                            }
                            setState(() {
                              isRecording = !isRecording;
                            });
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.purple.withAlpha(40),
                            child: Image.asset(
                              isRecording
                                  ? "assets/images/square.png"
                                  : "assets/images/mic.png",
                              width: 30,
                            ),
                          ),
                        ),
                        filled: false,
                        hintText: '   Message...',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(170, 0, 0, 0)),
                        border: InputBorder.none),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await chatViewModel.sendMessage();
                  scrollController
                      .jumpTo(scrollController.position.minScrollExtent);
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.cyan.withAlpha(40),
                  child: Image.asset(
                    "assets/images/send.png",
                    width: 36,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _goToBottomPage() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent * 1.2);
  }
}
