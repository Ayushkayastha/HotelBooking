import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hotel_app/backend/provider/date_range_notifier.dart';
import 'package:hotel_app/bottom_nav_bar.dart';
import 'package:provider/provider.dart'; // Import the HotelDetails class


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '/Users/ayushkayastha/StudioProjects/hotel_app/lib/webApp/api/.env');
  Stripe.publishableKey=dotenv.env['STRIPE_PUBLISH_KEY']!;
  await Stripe.instance.applySettings();
  EmailOTP.config(
    appName: 'EmailVerification',
    otpType: OTPType.numeric,
    emailTheme: EmailTheme.v1,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DateRangeNotifier()),
        // Other providers can go here
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 81, 212, 194)),
        useMaterial3: true,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color:Color.fromARGB(255, 81, 212, 194),
          ),
        ),
      ),
      home:  Bottomnavbar(indexno: 1),
    );
  }
}

