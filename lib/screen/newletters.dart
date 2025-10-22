import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsletterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Newsletter'),
        backgroundColor: Colors.deepPurple[700],
      ),*/
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'श्रद्धा         सबुरी',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'To be updated about the events at Sai Mandir subscribe to Sai Mandir’s newsletter.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 12),
            Text(
              'Newsletters are sent once a week with event updates. Please add saimandir@shirdisaimandirnc.org to your address book to avoid email filtering.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 12),
            Text(
              'Gmail has a feature to classify emails into tabs. If you have subscribed to Sai Mandir’s newsletter and not getting emails in your Inbox, please contact us at Mandir to verify your email ID in our contact list.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 24),
            Text(
              'Please Sign-up below for SSMNC News Letters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'First Name *'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your first name' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Last Name *'),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your last name' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email (required) *',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a valid email' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                  ),

                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Submit logic here
                      }
                    },
                    child: Text('Subscribe'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Text(
              'By submitting this form, you are consenting to receive marketing emails from: Sri Shirdi Saibaba Mandir Of North Carolina. You can revoke your consent at any time using the SafeUnsubscribe® link found at the bottom of every email. Emails are serviced by Constant Contact.',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 32),
            Divider(thickness: 1),
            SizedBox(height: 16),
            Text(
              "Sai Mandir's Facebook Page",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "You may also check and Like Sai Mandir’s Facebook page for updates about the Sai Mandir Events.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Replace with actual Facebook URL
                launchUrl(Uri.parse('https://www.facebook.com/SSMNC'));
              },
              child: Text(
                "Click Here",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Join Sai Mandir's Mail List",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Sign up to get weekly newsletters about the events at Sai Mandir!",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Replace with actual newsletter sign-up URL
                launchUrl(
                  Uri.parse(
                    'https://visitor.r20.constantcontact.com/manage/optin?v=0015rktL7J9dDAidLeetoY1DuTkSY7DNIAn8leSQOPpvs5UXrDad2uEkzcnTlJPFFROX4Cy6DY38lQfFTZqyKRVJ10HOSIzA-8gnHd2gRtljtI%3D',
                  ),
                );
              },
              child: Text(
                "Click Here",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.deepPurple,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
