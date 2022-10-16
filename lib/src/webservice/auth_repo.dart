import 'package:zaigo_assesment/src/constants/constant.dart';
import 'package:zaigo_assesment/src/model/LawersListResponse.dart';
import 'package:zaigo_assesment/src/model/loggedin_response.dart';
import 'package:zaigo_assesment/src/utils/app_preferences.dart';
import 'package:zaigo_assesment/src/views/mapview.dart';
import 'package:zaigo_assesment/src/webservice/apis/api_base_helper.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommonRepo {
  static final CommonRepo _singleton = CommonRepo._internal();

  factory CommonRepo() {
    return _singleton;
  }

  CommonRepo._internal();

  Future<LoggedInResponse?> loginVendor(
      String phoneNumber, String password) async {
    //phoneNumber = 7012405595
    //password = Test@123
    try {
      Map<String, dynamic> data = await ApiBaseHelper().postApiCall(
          url: kLoginCustomer,
          jsonData: {'phone_no': phoneNumber, 'password': password});
      LoggedInResponse? loggedInResponse = LoggedInResponse.fromJson(data);
      await AppPreferences.setAuthenticationToken(
          loggedInResponse.accessToken!);
      await AppPreferences.setLoginStatus(true);
      return loggedInResponse;
    } catch (e) {
      debugPrint('ERROR LOGIN ' + e.toString());
    }
    return null;
  }

  Future<LawersListResponse?> getUserList() async {
    try {
      Map<String, dynamic> data = await ApiBaseHelper().getApiCall(
        url: kSweepstakesListing,
      );
      LawersListResponse? lawersListResponse =
          LawersListResponse.fromJson(data);
      return lawersListResponse;
    } catch (e) {
      debugPrint('ERROR Fetching Data ' + e.toString());
    }
    return null;
  }

  Future<void> getLocationByAddress(BuildContext context, String dNO,
      String street, String city, String state, String country) async {
    try {
      String address =
          dNO + ", " + street + ", " + city + ", " + state + ", " + country;
      List<Location> locations = await locationFromAddress(address);
      double lat = locations[0].latitude;
      double long = locations[0].longitude;
      debugPrint('Latitude  ' + lat.toString());
      debugPrint('Longitude  ' + long.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MapsScreenPage(
          pos: LatLng(lat, long),
          dNo: dNO,
          street: street,
          city: city,
          state: state,
          country: country,
        );
      }));
    } catch (e) {
      debugPrint('Address exception ' + e.toString());
    }
  }
}
