import 'package:flutter/material.dart';

class SaiCarePage extends StatelessWidget {
  final List<String> events = [
    'Food Donation Drive',
    'Sandwich Seva',
    'Pillows for Cancer Patients',
    'Book Back Donation Drive',
    'Cloth Donation Drive',
    'Coat Donation Drive',
    'Office Supplies Donation Drive',
    'Blood Donation Drive',
    'Health Information Sessions',
    'Nepal Earthquake Relief',
    'Chennai Flood Relief',
    'Support for Blind Kids',
    'Support for Disabled People',
    'Support for Old Age People in India',
    'Assistance to Elderly',
    'Sandwich Seva',
    'Blood Donation',
  ];

  TableRow _buildRow(String left, String right) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(left, style: TextStyle(fontSize: 16)),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(right, style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildImageCard({required String imagePath, required String title}) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePath,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Sai Care'),
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
            SizedBox(height: 32),
            Text(
              'Sai Care',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              '“I am ever living to help and guide all who come to me, who surrender to me, and who seek refuge in me.” – Sai Baba',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 24),
            Text(
              'Donate through Sai Care',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Donate amount of your choice for the noble cause of Sai Care – Helping people who are in less fortune times.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Text(
              'We care through Sai Care',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Sri Shirdi Saibaba Mandir of North Carolina (SSMNC) promotes Sai philosophy and always tries to explore ways to help the less fortunate and provide opportunities for those in more fortunate times.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'SSMNC conducted various community events under Sai Care. Here are a few events that were conducted at Sai Mandir:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Table(
              columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(1)},
              border: TableBorder.all(color: Colors.deepPurple.shade100),
              children: [
                _buildRow('Food Donation Drive', 'Sandwich Seva'),
                _buildRow(
                  'Pillows for Cancer Patients',
                  'Book Back Donation Drive',
                ),
                _buildRow('Cloth Donation Drive', 'Coat Donation Drive'),
                _buildRow(
                  'Office Supplies Donation Drive',
                  'Blood Donation Drive',
                ),
                _buildRow(
                  'Health Information Sessions',
                  'Nepal Earthquake Relief',
                ),
                _buildRow('Chennai Flood Relief', 'Support for Blind Kids'),
                _buildRow(
                  'Support for Disabled People',
                  'Support for Old Age People in India',
                ),
              ],
            ),

            SizedBox(height: 32),
            Text(
              'Sai Care in Action',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildImageCard(
                    imagePath: 'assets/images/elderly_assistance.png',
                    title: 'Assistance to Elderly',
                  ),
                  SizedBox(width: 16),
                  _buildImageCard(
                    imagePath: 'assets/images/sandwich_seva.png',
                    title: 'Sandwich Seva',
                  ),
                  SizedBox(width: 16),
                  _buildImageCard(
                    imagePath: 'assets/images/blood_donation.png',
                    title: 'Blood Donation',
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),
            Text(
              'We have worked with several local non-profit organizations to ensure the materials and funds raised for specific causes are reached to the people in most need.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'With your support, we will conduct more events like the above that help the community around you. Material and money raised for this purpose will be spent for this cause only.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'Please donate an amount of your choice now for this noble cause and your donations will reach the people in need.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text(
              'For additional questions, please send an email to:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            SelectableText(
              'saicare@shirdisaimandirnc.org',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurple,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
