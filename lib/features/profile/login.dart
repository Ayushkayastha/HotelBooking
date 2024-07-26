import 'package:flutter/material.dart';
import 'package:hotel_app/features/profile/register.dart';
import '../../backend/API/login/LoginModel.dart';
import '../../backend/API/login/networkRequestLogin.dart';
import '../widget/button.dart';
import '../widget/text_form.dart';
import '../../backend/shared_preference.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _username = '';
  String _email = '';
  String user_id = '';
  String access_token = '';
  bool _isLoggedIn = false;
  final SharedPreferencesService _prefsService = SharedPreferencesService();

  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    bool isLoggedIn = await _prefsService.isLoggedIn();
    if (isLoggedIn) {
      var userInfo = await _prefsService.loadUserInfo();
      setState(() {
        _username = userInfo['username']!;
        _email = userInfo['email']!;
        user_id = userInfo['id']!;
        _isLoggedIn = true;
        print(user_id);
      });
    }
  }

  Future<void> _login() async {
    if (loginKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      if (username.isEmpty || password.isEmpty) {
        print('Please enter username and password');
        return;
      }

      LoginModel? loginResponse = await NetworkRequestLogin.login(username, password);

      if (loginResponse != null) {
        print('Successful login');
        print('User ID: ${loginResponse.details?.id}');
        _username = loginResponse.details!.username.toString();
        _email = loginResponse.details!.email.toString();
        user_id = loginResponse.details!.id.toString();
        access_token = loginResponse.token!.toString();

        // Save login state and user info to SharedPreferences
        await _prefsService.setLoggedIn(true);
        await _prefsService.saveUserInfo(_username, _email,user_id,access_token);
        print(access_token);

        setState(() {
          _isLoggedIn = true;
        });
      }
      else {
        print('Failed to login');
      }
    }
  }

  var loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (!_isLoggedIn)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: Form(
                key: loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Login to your Account',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF51D4C2), // Custom color
                      ),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                      child: Text(
                        'Don\'t have an account? Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    text_form('Please enter Username', 'Username', controller: _usernameController),
                    SizedBox(height: 20),
                    text_form('Please enter password', 'Password', obscureText: true, password: true, controller: _passwordController),
                    SizedBox(height: 50),
                    button(
                      'LOG IN',
                      _login,
                    ),
                  ],
                ),
              ),
            ),
          if (_isLoggedIn)
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF51D4C2),
                              Color(0xFF84FFF5)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(30),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: 0,
                        right: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person, size: 50, color: Color(0xFF51D4C2)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  buildProfileItem(context, Icons.person, _username),
                  buildProfileItem(context, Icons.cake, '2002/04/14'),
                  buildProfileItem(context, Icons.phone, '9861535353'),
                  buildProfileItem(context, Icons.camera_alt, 'Instagram account'),
                  buildProfileItem(context, Icons.email, _email),
                  buildProfileItem(context, Icons.visibility, 'Password'),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: button('Edit Profile', () {}),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: button(
                      'Log out',
                          () async {
                        // Clear login state and user info from SharedPreferences
                        await _prefsService.clearUserInfo();
                        setState(() {
                          _isLoggedIn = false;
                          _username = '';
                          _email = '';
                          user_id = '';
                          access_token = '';
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

Widget buildProfileItem(BuildContext context, IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFF51D4C2)),
        SizedBox(width: 16),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}
