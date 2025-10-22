import 'package:flutter/material.dart';
import 'package:temple_app/screen/admin_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  String errormessage = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  void _signIn() async {
    final id = _controllerEmail.text;
    final password = _controllerPassword.text;
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });
    }
    if (id == 'admin' && password == 'admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashBoardAdminPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ID or password is incorrect'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Sign In'),
        backgroundColor: Colors.deepOrange,

        /*leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),*/
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 30.0),
              //const Text(Words.signIn, style: AppTextStyles.xxlBold),
              ClipRRect(
                // The value (e.g., 8.0) controls how rounded the corners are.
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/icon/icon.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit
                      .cover, // Optional: ensures the image fills the space
                ),
              ),
              const SizedBox(height: 25.0),
              const Text(
                'Please enter admin id and password', // Added a placeholder for a welcome message
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _controllerEmail,
                        decoration: const InputDecoration(labelText: 'User ID'),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter User ID';
                          }
                          // Add more email validation if needed
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _controllerPassword,
                        obscureText: true, // Use this for passwords
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        errormessage,
                        style: TextStyle(backgroundColor: Colors.redAccent),
                      ),

                      ElevatedButton(
                        onPressed: _signIn, // Your sign-in method
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: const Text('Sign In'),
                      ),
                      if (_isLoading)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
