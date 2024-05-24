import 'package:flutter/material.dart';
import 'package:nexa_test/pages/ui/dashboard/dashboard.dart';
import 'package:nexa_test/pages/ui/login/login.dart';
import 'package:nexa_test/provider/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: value.isAuthenticated
                ? const DashboardPage()
                : const LoginPage(),
          );
        },
      ),
    );
  }
}
