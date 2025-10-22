import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final Map<String, Map<String, double>> donationData = {
    'Bhojan with Baba 2025': {
      'Silver Sponsorship': 251.0,
      'Gold Sponsorship': 501.0,
      'Diamond Sponsorship': 1001.0,
    },
    'Puja Sponsorships': {
      'Archana - Any Deity': 15.0,
      'Abhishekam - Any Deity': 25.0,
      'Flowers Sponsor': 116.0,
      'Annadanm/Prasadam Sponsor': 116.0,
    },
    'Abhishekam Sponsorships': {
      'SaiBaba-1 Year-Twice a week': 1501.0,
      'Ganesh-1 Year-Once a week': 501.0,
      'Datta & Anaga-1 Year-Once a week': 501.0,
      'Shiva-1 Year-Once a week': 751.0,
      'Karthekeya-1 Year-Once a Month': 251.0,
      'Ayyappa-1 Year-Once a Month': 351.0,
      'Sai Mula Virat-1 Year-4 times a Year': 1001.0,
      'All Deity Abhishekam-1 Year': 2501.0,
    },
    'Vastram / Shawl Sponsorships': {
      'Baba Shawl - 1 Time': 151.0,
      'All Deity Vastram - 1 Time': 301.0,
      'Karthekeya Vastram - 1 Time': 251.0,
      'Ganesh Vastram - 1 Time': 151.0,
      'Dattatreya Vastram - 1 Time': 151.0,
    },
    'Kalyanam Sponsorships': {
      'Sri Sita Rama Kalyanam': 151.0,
      'Sri Shiva Parvathi Kalyanam': 151.0,
      'Shiva Parvathi Kalyanam': 151.0,
      'All 4 Kalyanams - 1 Year': 501.0,
      'Vastram for 1 Kalyanam': 501.0,
      'Talambralu for 1 Kalyanam': 51.0,
    },
    'Havan Sponsorships': {
      'Sai Mulavirat Havan': 151.0,
      'Ganesh Havan': 151.0,
      'Dattatreya Havan': 151.0,
      'Chandi Havan': 151.0,
    },
    'Sai Care Sponsorship': {'Monthly': 116.0, 'Annual': 501.0, 'Weekly': 58.0},
    'Dollar-A-Day Sponsorship': {
      'One Dollar': 30.0,
      'Two Dollar': 60.0,
      'Three Dollar': 90.0,
    },
    'SSMNC Parking Expansion Sponsorship': {
      'Diamond Sponsor': 10000.0,
      'Platinum Sponsor': 5000.0,
      'Gold Sponsor': 1000.0,
      'Silver Sponsor': 500.0,
      'Other - for Parking': 101.0,
    },
    'Other Sponsorships': {
      'Sai Satya Vratam-1 Time': 25.0,
      'Sai Satya Vratam-1 Year': 251.0,
      'Anagastami Vratham-1 Time': 25.0,
      'Anagastami Vratham-1 Year': 251.0,
      'Sai / Datta Paduka Puja': 51.0,
      'Vahan / Car Puja': 51.0,
      'Prasadam Distrib. Supplies-1 Day': 25.0,
      'Prasadam Distrib. Supplies-1 Week': 150.0,
      'Prasadam Distrib. Supplies-1 Month': 501.0,
      'Other/General': 11.0,
    },
  };

  String? selectedType;
  String? selectedOption;
  List<Map<String, dynamic>> cart = [];

  double get totalAmount =>
      cart.fold(0.0, (sum, item) => sum + (item['amount'] as double));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Page'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text('Select Donation Type'),
              value: selectedType,
              isExpanded: true,
              items: donationData.keys.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value;
                  selectedOption = null;
                });
              },
            ),
            if (selectedType != null)
              DropdownButton<String>(
                hint: Text('Select Option'),
                value: selectedOption,
                isExpanded: true,
                items: donationData[selectedType!]!.entries.map((entry) {
                  final option = entry.key;
                  final amount = entry.value;
                  return DropdownMenuItem(
                    value: option,
                    child: Text('$option - \$${amount.toStringAsFixed(2)}'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),

            if (selectedOption != null)
              ElevatedButton(
                onPressed: () {
                  final amount = donationData[selectedType!]![selectedOption!]!;
                  setState(() {
                    cart.add({
                      'type': selectedType,
                      'option': selectedOption,
                      'amount': amount,
                    });
                    selectedOption = null;
                  });
                },
                child: Text('Add to Cart'),
              ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return ListTile(
                    title: Text('${item['type']} - ${item['option']}'),
                    trailing: Text('\$${item['amount'].toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            Text(
              'Total: \$${totalAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/payment',
                  arguments: {'total': totalAmount},
                );
              },
              child: Text('Donate'),
            ),
          ],
        ),
      ),
    );
  }
}
