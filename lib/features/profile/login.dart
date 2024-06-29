import 'package:flutter/material.dart';
import 'package:hotel_app/features/profile/register.dart';
import 'package:provider/provider.dart';
import '../../backend/API/login/LoginModel.dart';
import '../../backend/API/login/networkRequestLogin.dart';
import '../widget/button.dart';
import '../widget/text_form.dart';
import '../datas.dart';

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
        print('User ID: ${loginResponse.id}');
        _username=loginResponse.username.toString();
        _email=loginResponse.email.toString();

        Provider.of<Datas>(context, listen: false).login_out();

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
      body: Consumer<Datas>(
          builder: (context, datas, child){
         return Stack(
        children:[
          if(!datas.loggedin)Container(
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
                text_form('Please enter Username', 'Username',controller: _usernameController),
                SizedBox(height: 20),
                text_form('Please enter password', 'Password', obscureText: true,password :true, controller: _passwordController),
                SizedBox(height: 50),
                button(
                  'LOG IN',
                  _login,
                ),


              ],
            ),
          ),
        ),
          if(datas.loggedin)SingleChildScrollView(
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
                            Color(0xFF84FFF5)],
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
                  child: button('Edit Profile',(){}),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: button(
                      'Log out',
                          (){
                            Provider.of<Datas>(context, listen: false).login_out();
                          }),
                ),

              ],
            ),
          ),
        ],
      );
          }
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
