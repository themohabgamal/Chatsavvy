// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pillwise/src/models/my_message.dart';
import 'package:pillwise/src/res/colors.dart';
import 'package:pillwise/src/res/text_style.dart';

// ignore: must_be_immutable
class ChatMessage extends StatelessWidget {
  MyMessage message;
  int? hour = 12;
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
                const SizedBox(
                  height: 10,
                ),
                Material(
                  color: primaryColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: AutoSizeText(
                      message.content,
                      minFontSize: 18,
                      style:
                          bodyText2.copyWith(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    dateFormatter(
                        DateTime.fromMillisecondsSinceEpoch(message.dateTime)),
                    style:
                        bodyText2.copyWith(fontSize: 14, color: Colors.black54),
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(90),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  margin:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 40),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Text(
                          "~ ${message.senderName}",
                          style: bodyText2.copyWith(
                              fontSize: 17,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      AutoSizeText(
                        message.content,
                        minFontSize: 18,
                        style: bodyText2.copyWith(
                            fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    dateFormatter(
                        DateTime.fromMillisecondsSinceEpoch(message.dateTime)),
                    style:
                        bodyText2.copyWith(fontSize: 14, color: Colors.black54),
                  ),
                ),
              ],
            ),
          );
  }

  dateFormatter(DateTime date) {
    if (date.hour > hour!) {
      hour = date.hour - hour!;
    }
    return "$hour:${date.minute}";
  }
}
