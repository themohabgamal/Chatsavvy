import 'package:flutter/material.dart';
import 'package:pillwise/src/res/text_style.dart';

class AboutUsScreen extends StatelessWidget {
  static const String routeName = 'aboutUs';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        title: Text(
          'About Us',
          style: headline5.copyWith(fontSize: 28),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome to our Chat App!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'About Us:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Our Chat App is a modern and user-friendly messaging application that allows you to connect with friends, family, and colleagues. With our app, you can send text messages, share photos and videos, and even make voice and video calls!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Key Features:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '- Instant messaging: Send and receive messages in real-time.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Multimedia sharing: Share photos, videos, and documents.',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Voice and video calls: Make high-quality audio and video calls with your contacts.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions, suggestions, or feedback, feel free to reach out to us at support@chatapp.com.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
