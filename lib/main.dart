import 'dart:io';

import 'package:crudmvvm/cubit/user/user_cubit.dart';
import 'package:crudmvvm/data/data_provider/user/user_data_provider.dart';
import 'package:crudmvvm/presentation/screens/home/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:crudmvvm/data/repository/user_repository.dart';
import 'package:crudmvvm/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
    // ValueManager.customToast('Environment variables loaded successfully');
  } catch (e) {
    // ValueManager.customToast('Error loading environment variables: $e');
  }
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    final client = http.Client();
    // final repository = RepositoryProvider(create: (context)=> UserRepository(UserDataProvider(client)));
    return BlocProvider(
      create: (context) => UserCubit(UserRepository(UserDataProvider(client))),
      child: const MaterialApp(
        title: 'Flutter CRUD',
        home: MainScreen(),
      ),
    );
  }
}
