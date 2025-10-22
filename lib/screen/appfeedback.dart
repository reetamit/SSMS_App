import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class AppFeedbackPage extends StatefulWidget {
  @override
  State<AppFeedbackPage> createState() => _AppFeedbackPageState();
}

class _AppFeedbackPageState extends State<AppFeedbackPage> {
  final TextEditingController _commentController = TextEditingController();

  Future<void> _sendEmail(BuildContext context) async {
    final String subject = Uri.encodeComponent('Sai Mobile App Feedback');
    final String body = Uri.encodeComponent(_commentController.text);

    final Email email = Email(
      body: body,
      subject: subject,
      recipients: ['reetamit@gmail.com'],
      //cc: ['cc@example.com'],
      //bcc: ['bcc@example.com'],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    //await FlutterEmailSender.send(email);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thank You!'),
          content: Text(
            "Thank you for your feedback. We'll reach out to you in case any question.",
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Feedback'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This form is for app-related feedback',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'We love to hear about your feedback about this app and suggestions to improve. Kindly provide your name, email/number so that I can contact.'
              'To protect your identity, do not include any personal details in this form, such as your date of birth.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _commentController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Write your comment',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _sendEmail(context),
                icon: Icon(Icons.send),
                label: Text('Submit Feedback'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: Text(
                '@Build by Reetam Biswas\nPlease contact reetamit@gmail.com for any issues.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
