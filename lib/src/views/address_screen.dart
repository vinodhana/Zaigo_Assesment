import 'package:zaigo_assesment/src/webservice/auth_repo.dart';
import 'package:zaigo_assesment/src/widgets/custom_button.dart';
import 'package:zaigo_assesment/src/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController? _doorNoController;
  TextEditingController? _streetController;
  TextEditingController? _cityController;
  TextEditingController? _stateController;
  TextEditingController? _countryController;

  @override
  void initState() {
    _streetController = TextEditingController();
    _doorNoController = TextEditingController();
    _cityController = TextEditingController();
    _stateController = TextEditingController();
    _countryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.1,
        automaticallyImplyLeading: false,
        title: const Text(
          'Address',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          child: Center(
              child: ListView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(parent: ScrollPhysics()),
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _doorNoController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                fillColor: Colors.white,
                filled: true,
                keyboardType: TextInputType.streetAddress,
                maxLength: 80,
                obscureText: false,
                borderColor: Colors.grey,
                labelText: 'Door No',
                onChanged: (String? string) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Door No Details';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _streetController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                fillColor: Colors.white,
                filled: true,
                keyboardType: TextInputType.streetAddress,
                maxLength: 85,
                obscureText: false,
                borderColor: Colors.grey,
                labelText: 'Street',
                onChanged: (String? string) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Street Details';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _cityController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                fillColor: Colors.white,
                filled: true,
                keyboardType: TextInputType.streetAddress,
                maxLength: 85,
                obscureText: false,
                borderColor: Colors.grey,
                labelText: 'City',
                onChanged: (String? string) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter City Details';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _stateController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                fillColor: Colors.white,
                filled: true,
                keyboardType: TextInputType.streetAddress,
                maxLength: 85,
                obscureText: false,
                borderColor: Colors.grey,
                labelText: 'State',
                onChanged: (String? string) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter State Details';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _countryController,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                fillColor: Colors.white,
                filled: true,
                keyboardType: TextInputType.streetAddress,
                maxLength: 85,
                obscureText: false,
                borderColor: Colors.grey,
                labelText: 'Country',
                onChanged: (String? string) {},
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Country Details';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 60,
                  text: 'Submit',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  onPressed: () {
                    CommonRepo().getLocationByAddress(
                        context,
                        _doorNoController!.text,
                        _streetController!.text,
                        _cityController!.text,
                        _stateController!.text,
                        _countryController!.text);


                  })
            ],
          )),
        ),
      ),
    );
  }
}
