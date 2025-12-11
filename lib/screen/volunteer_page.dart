import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/mailer.dart';
import 'package:temple_app/localization/words.dart';
import 'package:temple_app/model/database_service.dart';
import 'package:temple_app/screen/admin_login.dart';
import 'package:temple_app/screen/contact_us.dart';
//import 'package:temple_app/model/mail_page.dart';

class VolunteerRegistrationPage extends StatefulWidget {
  @override
  _VolunteerRegistrationPageState createState() =>
      _VolunteerRegistrationPageState();
}

class _VolunteerRegistrationPageState extends State<VolunteerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  double totalHours = 0;
  String? selectedDesc;

  @override
  void initState() {
    super.initState();
    //Load categories when screen initializes
    listCategory();
  }

  // Assume you already have a list of descriptions
  List<dynamic> listOfCategories = [];

  Future<void> listCategory() async {
    final snapshot = await DatabaseService().read(
      path: Words.adminsettingsPath,
    );
    if (snapshot != null) {
      final data = snapshot.value as Map<dynamic, dynamic>?;

      if (data != null && data[Words.adminsettingsVcategories] is List) {
        setState(() {
          listOfCategories = List.from(
            data[Words.adminsettingsVcategories] as List,
          );
        });
      }
    }
  }

  Future<double> getVolunteerHourLimit() async {
    final snapshot = await DatabaseService().read(
      path: Words.adminsettingsPath,
    );

    double volunteerHourLimit = 0.0;

    if (snapshot != null) {
      final data = snapshot.value as Map<dynamic, dynamic>?;

      if (data != null && data[Words.adminsettingsVhourlimit] != null) {
        volunteerHourLimit = data[Words.adminsettingsVhourlimit];
      }
    }
    return volunteerHourLimit;
  }

  Future<double> _totalVolunteerHour(String emailparam, String phparam) async {
    final records = await DatabaseService().getVolunteerRecordbyEmailPh(
      path: Words.vHourPath,
      email: emailparam,
      phone: phparam,
    );

    double totalHoursSum = 0.0;

    for (var record in records) {
      if (record.containsKey(Words.vhourtotalhours)) {
        final num hours = record[Words.vhourtotalhours] ?? 0;
        totalHoursSum += hours.toDouble();
      }
    }
    return totalHoursSum;
  }

  // send mail to the user using smtp
  sendMailFromGmail(String sender, sub, text) async {
    // creating smtp server for gmail
    final gmailSmtp = gmail(
      dotenv.env["GMAIL_MAIL"]!,
      dotenv.env["GMAIL_PASSWORD"]!,
    );
    final message = Message()
      ..from = Address(dotenv.env["GMAIL_MAIL"]!, 'Mobile App Support')
      ..recipients.add("sssmnc@outlook.com")
      ..subject = sub
      ..text = text;

    try {
      final sendReport = await send(message, gmailSmtp);
      print('Message sent: $sendReport');
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _pickStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        startTime = picked;
        _calculateTotalHours(); // <-- recalc immediately
      });
    }
  }

  void _pickEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        endTime = picked;
        _calculateTotalHours(); // <-- recalc immediately
      });
    }
  }

  void _calculateTotalHours() {
    if (startTime != null && endTime != null) {
      final start = DateTime(2025, 1, 1, startTime!.hour, startTime!.minute);
      var end = DateTime(2025, 1, 1, endTime!.hour, endTime!.minute);

      // Handle case where end time is past midnight
      if (end.isBefore(start)) {
        end = end.add(Duration(days: 1));
      }

      final difference = end.difference(start).inMinutes / 60.0;
      setState(() {
        totalHours = difference;
      });
    }
  }

  String timeOfDayToString(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute'; // e.g. "14:30"
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final limit = await getVolunteerHourLimit();
      final alreadyDoneHours = await _totalVolunteerHour(
        emailController.text,
        phoneController.text,
      );

      // Check limit before saving
      if (alreadyDoneHours > limit) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Volunteer Hour Limit"),
            content: const Text("Your Volunteer Hour limit is reached!"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
        return; // Stop submission
      }

      // Save into table
      Map<String, dynamic> vHourData = {
        Words.vhourname: nameController.text,
        Words.vhouremail: emailController.text,
        Words.vhourphone: phoneController.text,
        Words.vhourdate:
            selectedDate?.toIso8601String() ?? DateTime.now().toIso8601String(),
        Words.vhourstarttime: timeOfDayToString(startTime!),
        Words.vhourendtime: timeOfDayToString(endTime!),
        Words.vhourtotalhours: totalHours,
        Words.vhourdesc: selectedDesc ?? '',
        Words.vhourapproved: 'Pending',
        Words.vhourapprovedBy: '',
      };

      try {
        await DatabaseService().create(path: Words.vHourPath, data: vHourData);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Your volunteer hours have been submitted for approval!',
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error creating event: $e')));
        return;
      }
    }
  }

  void _clearForm() {
    // Clear form
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    setState(() {
      selectedDate = null;
      startTime = null;
      endTime = null;
      totalHours = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SSSMNC Vollenteer hours'),
        backgroundColor: Colors.deepOrange,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Image.asset('assets/icon/icon.png', height: 45, width: 45),
          ),
        ],
      ),
      drawer: Drawer(
        //width: 220.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 120.00,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepOrange),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Temple Menu',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Image.asset(
                      'assets/icon/icon.png', // Replace with your actual image path
                      height: 40,
                      width: 40,
                    ),
                  ],
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.email),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => ContactInfoPage()));
              },
            ),

            ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text('Admin'),
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
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
              SizedBox(height: 24),

              // Date Picker
              ListTile(
                title: Text(
                  selectedDate == null
                      ? 'Select Date'
                      : DateFormat.yMMMd().format(selectedDate!),
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),
              SizedBox(height: 16),

              // Start Time Picker
              ListTile(
                title: Text(
                  startTime == null
                      ? 'Select Start Time'
                      : startTime!.format(context),
                ),
                trailing: Icon(Icons.access_time),
                onTap: _pickStartTime,
              ),
              SizedBox(height: 16),

              // End Time Picker
              ListTile(
                title: Text(
                  endTime == null
                      ? 'Select End Time'
                      : endTime!.format(context),
                ),
                trailing: Icon(Icons.access_time),
                onTap: _pickEndTime,
              ),
              SizedBox(height: 16),

              // Auto-calculated Total Hours
              Text(
                'Total Hours: ${totalHours.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                initialValue: selectedDesc,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: listOfCategories.map((desc) {
                  return DropdownMenuItem<String>(
                    value: desc.toString(),
                    child: Text(desc.toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDesc = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
              ),
              SizedBox(height: 24),

              ElevatedButton.icon(
                icon: Icon(Icons.volunteer_activism),
                label: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () async {
                  // First validate and submit form
                  _submitForm();

                  // Then send mail
                  await sendMailFromGmail(
                    emailController.text.trim(),
                    'Volunteer Hours are requested by ${nameController.text}',
                    'Dear Sai Baba Committee Members,\n\n'
                        'Volunteer Hours are requested by ${nameController.text} for your approval.\n\n'
                        'Details:\n'
                        'Name: ${nameController.text}\n'
                        'Email: ${emailController.text}\n'
                        'Phone: ${phoneController.text}\n'
                        'Date: ${selectedDate != null ? DateFormat.yMMMd().format(selectedDate!) : 'Not selected'}\n'
                        'Start Time: ${startTime != null ? startTime!.format(context) : 'Not selected'}\n'
                        'End Time: ${endTime != null ? endTime!.format(context) : 'Not selected'}\n'
                        'Total Hours: ${totalHours.toStringAsFixed(2)}\n'
                        'Description: $selectedDesc\n\n'
                        'Best regards,\n'
                        'Sai Baba Temple App',
                  );
                  _clearForm();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
