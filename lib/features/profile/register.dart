import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/profile/login.dart';
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

  Future<void> _register() async {
    if (registerKey.currentState!.validate()) {
      final username = _usernameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final city = _cityController.text;
      final country = _countryController.text;
      final phone = _phoneController.text;



      if (username.isEmpty || email.isEmpty || password.isEmpty) {
        print('Please fill all fields');
        return;
      }

      String? registerResponse = await NetworkRequestRegister.register(username, email, password,city,country,phone);

      if (registerResponse != null) {
        print('User has been created successfully');
        Navigator.pop(context);
      } else {
        print('Failed to register');
      }
    }
  }

  var registerKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                text_form('Please enter your Username', 'Username', controller: _usernameController),
                SizedBox(height: 20),
                text_form('Please enter Email', 'Email',email: true, controller: _emailController),
                SizedBox(height: 20),
                text_form('Please enter city', 'city', controller: _cityController),
                SizedBox(height: 20),
                text_form('Please enter country','country',controller: _countryController),
                SizedBox(height: 20),
                text_form('Please enter phone','phone', controller: _phoneController),
                SizedBox(height: 20),
                text_form('Please enter Password', 'Password',password: true, obscureText: true, controller: _passwordController),
                SizedBox(height: 50),
                button(
                  'SIGN UP',
                  _register,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
