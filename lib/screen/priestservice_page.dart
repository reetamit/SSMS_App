import 'package:flutter/material.dart';
import 'package:temple_app/model/priestservice.dart';

// Step 2: Set up the form widget
class PriestServiceForm extends StatefulWidget {
  const PriestServiceForm({super.key});

  @override
  _PriestServiceFormState createState() => _PriestServiceFormState();
}

class _PriestServiceFormState extends State<PriestServiceForm> {
  final _formKey = GlobalKey<FormState>();

  // Sample data
  // The list of services based on the provided table
  final List<PriestService> services = [
    PriestService(name: 'Archana', templePrice: '15', homePrice: 'N/A'),
    PriestService(name: 'Ayushya Homam', templePrice: '201', homePrice: '251'),
    PriestService(
      name: 'Abdeekam or Hiranya Shradham or Taddinam',
      templePrice: 'N/A',
      homePrice: '151',
    ),
    PriestService(name: 'Aksharabhyasam', templePrice: '101', homePrice: '151'),
    PriestService(name: 'Anna Prasanna', templePrice: '101', homePrice: '151'),
    PriestService(name: 'Bhoomi Pooja', templePrice: 'N/A', homePrice: '201'),
    PriestService(
      name: 'Chuda Karma or Hair Offering',
      templePrice: '101',
      homePrice: 'N/A',
    ),
    PriestService(
      name:
          'Gruha Pravesam or House Warming(Ganapathi Pooja and Navagraha Pooja)',
      templePrice: 'N/A',
      homePrice: '301',
    ),
    PriestService(
      name: 'Gruha Pravesam or House Warming and Satyanarayana Swami Pooja',
      templePrice: 'N/A',
      homePrice: '351',
    ),
    PriestService(name: 'Marriage', templePrice: 'Call us', homePrice: '501'),
    PriestService(name: 'Naamakaranam', templePrice: '101', homePrice: '151'),
    PriestService(
      name: 'Navagraha Shanti Puja',
      templePrice: '201',
      homePrice: '251',
    ),
    PriestService(
      name: 'New Business Inauguration',
      templePrice: 'N/A',
      homePrice: '151',
    ),
    PriestService(name: 'Pallaki Seva', templePrice: 'N/A', homePrice: '501'),
    PriestService(name: 'Punyavachanam', templePrice: 'N/A', homePrice: '151'),
    PriestService(
      name: 'Satyanarayana Pooja',
      templePrice: '151',
      homePrice: '201',
    ),
    PriestService(
      name: 'Vahana or Car Pooja',
      templePrice: '51',
      homePrice: 'N/A',
    ),
  ];

  // Form state variables
  PriestService? selectedService;
  String? selectedLocation; // 'temple' or 'home'
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String name = '';
  String email = '';
  String phone = '';

  // Step 4: Add date and time pickers
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // Step 6: Handle form submission and navigate to confirmation
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (selectedDate == null || selectedTime == null) {
        // Show an error if date/time are not picked
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select both date and time')),
        );
        return;
      }

      final DateTime bookingDateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      final bookingDetails = {
        'service': selectedService!.name,
        'location': selectedLocation,
        'price': selectedLocation == 'temple'
            ? selectedService!.templePrice
            : selectedService!.homePrice,
        'dateTime': bookingDateTime,
        'name': name,
        'email': email,
        'phone': phone,
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ConfirmationScreen(bookingDetails: bookingDetails),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Priest Service'),
        backgroundColor: Colors.deepOrange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Image.asset(
              'assets/icon/icon.png', // Replace with your actual image path
              height: 45,
              width: 45,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Step 3: Service Dropdown
              DropdownButtonFormField<PriestService>(
                isExpanded:
                    true, // This property allows the dropdown to expand its width
                decoration: const InputDecoration(labelText: 'Select Service'),
                value: selectedService,
                items: services.map((service) {
                  return DropdownMenuItem<PriestService>(
                    value: service,
                    child: service.name.length > 20
                        ? Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              service.name,
                              overflow: TextOverflow
                                  .ellipsis, // Optional: use ellipsis for very long names
                              maxLines: 2, // Allow up to 2 lines of text
                            ),
                          )
                        : Text(service.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedService = value;
                    selectedLocation = null;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a service' : null,
              ),
              const SizedBox(height: 16),

              // Step 3: Location Dropdown (conditionally shown)
              if (selectedService != null)
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Location',
                  ),
                  value: selectedLocation,
                  items: [
                    DropdownMenuItem(
                      value: 'temple',
                      child: Text(
                        selectedService!.templePrice != 'N/A'
                            ? 'Temple (\$${selectedService!.templePrice})'
                            : 'Temple (N/A)',
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'home',
                      child: Text(
                        selectedService!.homePrice != 'N/A'
                            ? 'Home (\$${selectedService!.homePrice})'
                            : 'Home (N/A)', // Display 'N/A' if homePrice is null
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Please select a location' : null,
                ),
              const SizedBox(height: 16),

              // Step 4: Date Picker
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Select Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                controller: TextEditingController(
                  text: selectedDate == null
                      ? ''
                      : selectedDate.toString().split(' ')[0],
                ),
                onTap: () => _selectDate(context),
                validator: (value) =>
                    value!.isEmpty ? 'Please select a date' : null,
              ),
              const SizedBox(height: 16),

              // Step 4: Time Picker
              TextFormField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Select Time',
                  suffixIcon: Icon(Icons.access_time),
                ),
                controller: TextEditingController(
                  text: selectedTime == null
                      ? ''
                      : selectedTime!.format(context),
                ),
                onTap: () => _selectTime(context),
                validator: (value) =>
                    value!.isEmpty ? 'Please select a time' : null,
              ),
              const SizedBox(height: 16),

              // Step 5: Contact Info
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (value) => name = value!,
                validator: (value) =>
                    value!.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value!,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.isEmpty || !value.contains('@')
                    ? 'Enter a valid email'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                onSaved: (value) => phone = value!,
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Phone number is required' : null,
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Proceed to Confirmation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Step 6: Confirmation Screen
class ConfirmationScreen extends StatelessWidget {
  final Map<String, dynamic> bookingDetails;

  const ConfirmationScreen({super.key, required this.bookingDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Booking'),
        backgroundColor: Colors.deepOrange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Image.asset(
              'assets/icon/icon.png', // Replace with your actual image path
              height: 45,
              width: 45,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please confirm your booking details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Service: ${bookingDetails['service']}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Location: ${bookingDetails['location'] == 'temple' ? 'Temple' : 'Home'}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Price: \$${(bookingDetails['price'] as String)}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Date: ${(bookingDetails['dateTime'] as DateTime).toString().split(' ')[0]}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Time: ${TimeOfDay.fromDateTime(bookingDetails['dateTime'] as DateTime).format(context)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              'Name: ${bookingDetails['name']}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Email: ${bookingDetails['email']}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Phone: ${bookingDetails['phone']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Add your final submission logic here (e.g., to a backend)
                  Navigator.popUntil(
                    context,
                    (route) => route.isFirst,
                  ); // Go back to the form start
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking submitted successfully!'),
                    ),
                  );
                },
                child: const Text('Confirm and Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
