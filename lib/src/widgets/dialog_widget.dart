import 'package:zaigo_assesment/src/utils/app_preferences.dart';
import 'package:zaigo_assesment/src/views/login_screen.dart';
import 'package:zaigo_assesment/src/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({Key? key}) : super(key: key);

  Widget _Row(String image1, String text, String image2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              image1,
              width: 30,
              height: 30,
            ),
          ),
          SizedBox(width: 5),
          Expanded(flex: 3, child: Text(text)),
          const Spacer(),
          Expanded(
            flex: 1,
            child: Image.asset(
              image2,
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Column(
            children: const [
              Text(
                'Are You sure you want to logout?',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.black54),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomButton(
                height: 40,
                width: 100,
                onPressed: () {
                  //Navigator.pushNamedAndRemoveUntil(context);
                },
                text: 'No',
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              CustomButton(
                height: 40,
                width: 100,
                onPressed: () async {
                  await AppPreferences.logoutClearPreferences();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                },
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Colors.white),
                text: 'Yes',
              )
            ],
          ),
        ],
      ),
    );
  }
}
