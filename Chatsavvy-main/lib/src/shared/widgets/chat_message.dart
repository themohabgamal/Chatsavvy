// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pillwise/src/models/my_message.dart';
import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/res/text_style.dart';

// ignore: must_be_immutable
class ChatMessage extends StatelessWidget {
  MyMessage message;
  ChatMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return message.senderId == FirebaseAuth.instance.currentUser!.uid
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Text(
                    message.senderName,
                    style: bodyText2.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20)),
                      ),
                      child: Text(
                        message.content,
                        style: bodyText2.copyWith(fontSize: 16),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    CachedNetworkImage(
                      imageUrl: message.senderImage,
                      fit: BoxFit.fill,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      placeholder: (context, url) => const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: primaryColor),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.person, color: Colors.white),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    dateFormatter(
                        DateTime.fromMillisecondsSinceEpoch(message.dateTime)),
                    style:
                        bodyText2.copyWith(fontSize: 14, color: Colors.white30),
                  ),
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.senderName,
                style: bodyText2.copyWith(fontSize: 16),
              ),
              Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: message.senderImage,
                    fit: BoxFit.fill,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: primaryColor),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person, color: Colors.white),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      message.content,
                      style:
                          bodyText2.copyWith(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  dateFormatter(
                      DateTime.fromMillisecondsSinceEpoch(message.dateTime)),
                  style:
                      bodyText2.copyWith(fontSize: 14, color: Colors.white30),
                ),
              ),
            ],
          );
  }

  dateFormatter(DateTime date) {
    return "${date.hour}:${date.minute}";
  }
}
