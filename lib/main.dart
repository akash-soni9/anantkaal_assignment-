import 'package:anantkaal_assignment/screens/details.dart';
import 'package:anantkaal_assignment/screens/home.dart';
import 'package:anantkaal_assignment/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/chat_page.dart';
import 'screens/login_screen.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC6bAX_OWwniHbiIuECsZYh7qjKe_djxVY",
          authDomain: "assignment-anantkaal.firebaseapp.com",
          projectId: "assignment-anantkaal",
          storageBucket: "assignment-anantkaal.appspot.com",
          messagingSenderId: "384039961058",
          appId: "1:384039961058:web:4b0ecfc5582419df1a39bb",)
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Anantkaal',
        theme: ThemeData(
          // Apply the custom Cherry Swash TextTheme globally
          textTheme: TextStyles.cherrySwashTextTheme,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => AuthChecker(),         // Default route
          "/details":(context)=>Details(),
          '/login': (context) => LoginScreen(),     // Login Screen
          '/chat': (context) => ChatPage(),// Additional screen for user profile, as an example
        },

      ),
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isAuthenticated) {
          // If authenticated, return Details() or ChatPage based on first-time login status
          return authProvider.isFirstTimeLogin ? ChatPage(): Details();
        } else {
          // If not authenticated, return the home or login screen
          return const Home(); // Replace with your login page
        }
      },
    );
  }
}

