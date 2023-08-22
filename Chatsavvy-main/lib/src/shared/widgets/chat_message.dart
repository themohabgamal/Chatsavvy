// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pillwise/src/models/my_message.dart';
import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/res/text_style.dart';

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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  message.senderName,
                  style: bodyText2.copyWith(fontSize: 16),
                ),
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
                  style: bodyText2.copyWith(fontSize: 16, color: Colors.black),
                ),
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
