import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future createPaymentIntent({
  required amount,
  required currency,
}) async{
  final url=Uri.parse("https://api.stripe.com/v1/payment_intents");
  final secretKey=dotenv. env ["STRIPE_SECRET_KEY"]!;
  final body= {
    'amount': amount,
    'currency':currency,
  };
  final response= await http.post(
    url,
    headers: {
      "Authorization": "Bearer $secretKey",
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: body,
  );
  if(response.statusCode==200)
  {
    var json=jsonDecode(response.body);
    print (json);
    return json;
  }
  else
    print("error in calling payment intent");

}