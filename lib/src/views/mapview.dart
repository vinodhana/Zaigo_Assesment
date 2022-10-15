import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_videos/src/webservice/auth_repo.dart';
import 'package:flutter_videos/src/widgets/custom_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreenPage extends StatefulWidget {
  const MapsScreenPage(
      {Key? key,
      this.pos,
      this.dNo,
      this.street,
      this.city,
      this.state,
      this.country})
      : super(key: key);
  final LatLng? pos;
  final String? dNo;
  final String? street;
  final String? city;
  final String? state;
  final String? country;

  @override
  _MapsScreenPageState createState() => _MapsScreenPageState();
}

class _MapsScreenPageState extends State<MapsScreenPage> {
  Completer<GoogleMapController> mapsController = Completer();
  late LatLng position;
  late CameraPosition initialCamera;

  Timer? searchOnStoppedTyping;

  TextEditingController doorNoController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController postalController = TextEditingController();

  @override
  void initState() {
    position = widget.pos!;
    initialCamera = CameraPosition(
      target: position,
      zoom: 16,
    );
    doorNoController.text = widget.dNo!;
    streetController.text = widget.street!;
    cityController.text = widget.city!;
    stateController.text = widget.state!;
    countryController.text = widget.country!;

    // _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: SafeArea(child: buildStack()),
    );
  }

  Widget buildMapContainer() {
    return GoogleMap(
      padding: const EdgeInsets.only(bottom: 24, top: 40),
      compassEnabled: true,
      mapToolbarEnabled: true,
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      mapType: MapType.normal,
      onCameraMove: _onCameraMove,
      initialCameraPosition: initialCamera,
      onMapCreated: (GoogleMapController controller) {
        mapsController.complete(controller);
      },
    );
  }

  _onChangeHandler(LatLng position) {
    const duration = Duration(milliseconds: 500);
    if (searchOnStoppedTyping != null) {
      setState(() => searchOnStoppedTyping!.cancel());
    }
    setState(
        () => searchOnStoppedTyping = Timer(duration, () => search(position)));
  }

  search(LatLng position) {
    this.position = position;
    debugPrint('${position.latitude} ${position.longitude}');
  }

  Stack buildStack() {
    return Stack(
      children: <Widget>[
        GoogleMap(
          compassEnabled: true,
          mapToolbarEnabled: true,
          padding: const EdgeInsets.only(bottom: 130, top: 60),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          mapType: MapType.normal,
          onCameraMove: _onCameraMove,
          initialCameraPosition: initialCamera,
          onMapCreated: (GoogleMapController controller) {
            mapsController.complete(controller);
          },
        ),
        const Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: Icon(
            Icons.room,
            color: Colors.red,
            size: 40,
          ),
        ),
        Visibility(
          visible: true,
          child: Positioned(
            left: 20,
            right: 20,
            top: 10,
            child: Row(
              children: [
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.arrow_back),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: true,
          child: DraggableScrollableSheet(
            maxChildSize: 1.0,
            initialChildSize: 0.20,
            minChildSize: 0.15,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Card(
                  elevation: 12.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 12),
                        Container(
                          height: 5,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        const SizedBox(height: 24),
                        const SizedBox(height: 16),
                        createTextFeild(
                          hint: 'Door No',
                          label: 'Enter Door No',
                          controller: doorNoController,
                          onChanged: (string) {
                            //registerRequest.apartment = string;
                          },
                        ),
                        const SizedBox(height: 8),
                        createTextFeild(
                          hint: 'Street',
                          label: 'Enter Street',
                          controller: streetController,
                          onChanged: (string) {
                            // registerRequest.street = string;
                          },
                        ),
                        const SizedBox(height: 8),
                        createTextFeild(
                          hint: 'City',
                          label: 'Enter city',
                          controller: cityController,
                          onChanged: (string) {
                            // registerRequest.city = string;
                          },
                        ),
                        const SizedBox(height: 8),
                        createTextFeild(
                          hint: 'State',
                          label: 'Enter state',
                          controller: stateController,
                          onChanged: (string) {
                            //  registerRequest.state = string;
                          },
                        ),
                        const SizedBox(height: 8),
                        createTextFeild(
                          hint: 'Country',
                          label: 'Enter country',
                          controller: countryController,
                          onChanged: (string) {
                            //registerRequest.country = string;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          onPressed: () async {

                            CommonRepo().getLocationByAddress(
                                context,
                                doorNoController.text,
                                streetController.text,
                                cityController.text,
                                stateController.text,
                                countryController.text);
                          },
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  tileMode: TileMode.clamp,
                                  colors: [Colors.blue, Colors.blueAccent],
                                ),
                                borderRadius: BorderRadius.circular(6)),
                            child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: const Text(
                                'Get address',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onCameraMove(CameraPosition position) {
    _onChangeHandler(position.target);
  }

  Widget createTextFeild(
      {required String hint,
      required String label,
      TextInputType type = TextInputType.streetAddress,
      Function(String? string)? onChanged,
      TextEditingController? controller,
      List<TextInputFormatter>? inputFormatters,
      bool readOnly = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          hint,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        const SizedBox(height: 4),
        CustomTextField(
          errorStyle: const TextStyle(color: Colors.black),
          controller: controller,
          inputFormatters: inputFormatters,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          labelText: label,
          keyboardType: type,
          maxLength: 60,
          readOnly: readOnly,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please ${label.toLowerCase()}';
            } else if (value.length < 2) {
              return 'please enter atleast 2 characters';
            }
            return null;
          },
          onChanged: onChanged,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
