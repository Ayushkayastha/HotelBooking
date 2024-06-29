import 'package:flutter/material.dart';

Widget text_form(String labelText, String hintText, {bool obscureText = false,bool password=false,bool email=false,TextEditingController? controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelText,
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
      SizedBox(height: 8),
      TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),

        validator: (value){

         if(password){
          if(value==null || value.isEmpty)
            {
              return "password cannot be empty";
            }
          else if (value.length<5)
            {
               return"password must be of 5 character";
            }
         }

          if(email){
          if (value == null || value.isEmpty) {
            return "Email is empty";
          }
          else if (value.length <= 2) {
            return "You email is Invalid";
          }
          else if(!isValidEmail(value)) {
            return "Invalid email";
          }
          }

          return null;
        },
      ),
    ],
  );
}

bool isValidEmail(String email) {
  // Define a regular expression for validating an Email
  return RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(email);
}
