import 'package:email_otp/email_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/widget/text_form.dart';
import '../../backend/API/register/networkRequestRegister.dart';
import '../widget/button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  var registerKey = GlobalKey<FormState>();
  bool otpPage = true;

  Future<void> _register() async {
    // Ensure form validation before registration

      final username = _usernameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final city = _cityController.text;
      final country = _countryController.text;
      final phone = _phoneController.text;


      String? registerResponse = await NetworkRequestRegister.register(
          username, email, password, city, country, phone);

      if (registerResponse != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Your account has been registered")));
        print('User has been created successfully');
        Navigator.pop(context);
      }

      else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to registered")));
        setState(() {
          otpPage = true;
        });
        print('Failed to register');
      }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        if (otpPage)
          SingleChildScrollView(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: Form(
                key: registerKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Text(
                      'Create new Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF51D4C2),
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Already Registered? Login',
                        style: TextStyle(
                          color: Color(0xFF51D4C2),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    text_form(
                      'Please enter your Username',
                      'Username',
                      controller: _usernameController,
                    ),
                    SizedBox(height: 20),
                    text_form(
                      'Please enter Email',
                      'Email',
                      email: true,
                      controller: _emailController,
                    ),
                    SizedBox(height: 20),
                    text_form(
                      'Please enter city',
                      'city',
                      controller: _cityController,
                    ),
                    SizedBox(height: 20),
                    text_form(
                      'Please enter country',
                      'country',
                      controller: _countryController,
                    ),
                    SizedBox(height: 20),
                    text_form(
                      'Please enter phone',
                      'phone',
                      controller: _phoneController,
                    ),
                    SizedBox(height: 20),
                    text_form(
                      'Please enter Password',
                      'Password',
                      password: true,
                      obscureText: true,
                      controller: _passwordController,
                    ),
                    SizedBox(height: 50),
                    button(
                      'SIGN UP',
                          () async {
                            if(registerKey.currentState!.validate()) {
                              setState(() {
                                otpPage = false;
                              });
                              if (await EmailOTP.sendOTP(
                                  email: _emailController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("OTP has been sent")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("OTP failed to send")));
                                setState(() {
                                  otpPage = true;
                                });
                              }
                            }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (!otpPage)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('The OTP has been sent to your email'),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _otpController,
                    decoration: InputDecoration(
                      hintText: 'Enter your OTP',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "OTP is empty";
                      } else if (value.length <= 5) {
                        return "Your OTP is invalid";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [Color(0xFF51D4C2), Color(0xFF84FFF5)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (EmailOTP.verifyOTP(otp: _otpController.text)) {
                          print('Valid OTP');
                          await _register(); // Ensure correct call to _register
                        } else {
                          print('Invalid OTP');
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Invalid OTP")));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ]),
    );
  }
}
