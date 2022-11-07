import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/formulario/form_nuevo.dart';
import 'package:todo_app/screens/home.dart';

import 'observables/app_management.dart';
void main() {
  runApp(MultiProvider(providers: [
    Provider<AppManagement>(create: (_) => AppManagement())
  ], child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    AppManagement appManagement = Provider.of<AppManagement>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tareas',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // home: MyHomePage(appManagement:appManagement),
      initialRoute: '/home',
      routes: {
        '/home':(context) => Home(appManagement: appManagement),
        '/form':(context) => FormNuevo()
      },
    );
  }
}
