import 'package:flutter/material.dart';

class BookingPujaPage extends StatefulWidget {
  const BookingPujaPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingPujaPageState createState() => _BookingPujaPageState();
}

class _BookingPujaPageState extends State<BookingPujaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String selectedPuja = 'Ganesh Puja';

  final List<String> pujaTypes = [
    'Ganesh Puja',
    'Lakshmi Puja',
    'Satyanarayan Puja',
    'Navagraha Puja',
    'Rudrabhishek',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Puja'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your phone number' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: selectedPuja,
                items: pujaTypes.map((puja) {
                  return DropdownMenuItem(value: puja, child: Text(puja));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPuja = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select Puja Type',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Preferred Date',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please select a date' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                icon: Icon(Icons.book_online),
                label: Text('Book Puja'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Submit booking to backend or send email
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Puja booking submitted')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
