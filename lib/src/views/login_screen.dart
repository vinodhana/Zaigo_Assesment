import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_videos/src/blocs/auth_bloc/auth_bloc.dart';
import 'package:flutter_videos/src/views/home_screen.dart';
import 'package:flutter_videos/src/views/main_screen.dart';
import 'package:flutter_videos/src/widgets/custom_text_field.dart';

import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthBloc? _authBloc;
  final TextEditingController phoneTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 170, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Center(
                child: Text(
              "Login Screen",
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 40.4),
            CustomTextField(
              controller: phoneTextEditingController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              fillColor: Colors.white,
              filled: true,
              keyboardType: TextInputType.streetAddress,
              maxLength: 85,
              obscureText: false,
              borderColor: Colors.grey,
              labelText: 'Phone Number',
              onChanged: (String? string) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Phone Number';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.4),
            CustomTextField(
              controller: passwordTextEditingController,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              fillColor: Colors.white,
              filled: true,
              keyboardType: TextInputType.streetAddress,
              maxLength: 85,
              obscureText: false,
              borderColor: Colors.grey,
              labelText: 'Password',
              onChanged: (String? string) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter Password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20.4),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
                } else if (state is AuthSuccessful) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MainScreen();
                  }));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.white,
                      content: Text(
                        'Welcome',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20),
                      )));
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.white,
                      content: Text(
                        'Error',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 20),
                      )));
                }
              },
              child: CustomButton(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 50,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
                onPressed: () {
                  _authBloc!.add(LoginEvent(
                      email: phoneTextEditingController.text,
                      password: passwordTextEditingController.text));
                },
                text: "Login",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
