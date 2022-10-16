import 'package:zaigo_assesment/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:zaigo_assesment/src/views/splash_screen.dart';
import 'package:zaigo_assesment/src/webservice/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc(CommonRepo())),
        ],
        child: const MaterialApp(
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
