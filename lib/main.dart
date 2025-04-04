import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palindrome_checker_app/features/core/utils/hive_setup.dart';
import 'package:palindrome_checker_app/features/palindrome/presentation/bloc/palindrome_bloc.dart';
import 'package:palindrome_checker_app/features/palindrome/presentation/screens/palindrome_checker_screen.dart';

void main() async{
  await HiveSetup().initHive();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PalindromeBloc()..add(const GetHistoryEvent())),
      ],
      child: MaterialApp(
        ///light and dark themes can be implemented later on
        ///later on set up a global navigator key, deeplinks etc.
        initialRoute: '/main',
        routes: {
          '/main': (context) => const PalindromeCheckerScreen(),
        },
      ),
    );
  }
}

