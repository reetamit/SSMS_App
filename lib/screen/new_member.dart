import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewMemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Membership'),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'श्रद्धा         सबुरी',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            SizedBox(height: 32),
            Text(
              'SSMNC currently offers membership promotions for New & Existing members.\n\nPlease talk to one of the front desk admins to learn more about our promotion.',
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Text(
              'SSMNC offers various membership levels. If you are interested in becoming a member of our beloved Mandir, please contact the temple registration desk to discuss the various levels of membership opportunities we have for you.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 24),
            Text(
              'SSMNC current Membership / Patronship levels available for our devotees',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Note:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildBullet(
              'All donations must be made under the “General” or “Membership” donation category to be considered for membership/patronship.',
            ),
            _buildBullet(
              'Donations made towards Religious puja services or other services (e.g., building fund, deity donations) are NOT considered for membership.',
            ),
            _buildBullet(
              'To become a member, devotees must complete payment of all required donations within 12 months from the date pledged.',
            ),
            _buildBullet(
              'For upgrading membership, there is no 12-month limitation. Donations made under “General Donation” or “Membership” can be accumulated toward upgrades.',
            ),
            SizedBox(height: 24),
            Text(
              'Membership Form',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Replace with actual form URL
                launchUrl(
                  Uri.parse(
                    'https://ssmnc.org/wp-content/uploads/2025/06/SSMNC-Membership-Form.pdf',
                  ),
                );
              },
              child: Text(
                'Click here to Download Membership Form',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.deepPurple,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'SSMNC Bylaws',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Replace with actual bylaws URL
                launchUrl(
                  Uri.parse(
                    'https://ssmnc.org/wp-content/uploads/2025/05/Sai_Mandir_NC_SSMNC_Bylaws_Final-2022-2025_Board_Amendments.pdf',
                  ),
                );
              },
              child: Text(
                'Click here to Download SSMNC Bylaws',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.deepPurple,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Replace with actual nomination form URL
                launchUrl(
                  Uri.parse(
                    'https://ssmnc.org/wp-content/uploads/2025/06/SSMNC-Boards-Nomination-Form-for-2025-2027.docx',
                  ),
                );
              },
              child: Text(
                'Click here for SSMNC Nomination Form : 2025',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.deepPurple,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Membership Levels & Eligibility Chart',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FullScreenImageViewer()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/membership_chart.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              'The image below outlines the current SSMNC membership levels and the corresponding eligibility criteria for participation in the SSMNC Board of Trustee (BOT) & Board of Directors (BOD).',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => FullScreenImgViewer()),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/eligibility_criteria.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

class FullScreenImageViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Membership Chart'),
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 5.0,
          child: Image.asset('assets/images/membership_chart.png'),
        ),
      ),
    );
  }
}

class FullScreenImgViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Membership Chart'),
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 5.0,
          child: Image.asset('assets/images/eligibility_criteria.png'),
        ),
      ),
    );
  }
}
