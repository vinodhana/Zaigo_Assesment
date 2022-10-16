import 'package:zaigo_assesment/src/views/address_screen.dart';
import 'package:zaigo_assesment/src/views/home_screen.dart';
import 'package:zaigo_assesment/src/views/photo_gallery.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.isFromSignUp = false}) : super(key: key);
  final bool? isFromSignUp;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  ScrollController? scrollController;

  Future<bool> _onWillPop(int index) {
    switch (index) {
      case 0:
        setSelectedIndex(0);
        return Future.value(false);
      case 2:
        setSelectedIndex(0);
        return Future.value(false);
      case 3:
        setSelectedIndex(0);
        return Future.value(false);
      default:
        return Future.value(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(_selectedIndex);
      },
      child: Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(),
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: getScreensList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getScreensList() {
    return [
      const HomePage(),
      const PhotoGalleryScreen(),
      const AddressScreen(),
    ];
  }

  void setSelectedIndex(int? selectedIndex) {
    setState(() {
      _selectedIndex = selectedIndex!;
    });
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_camera,color: Colors.blue,),

          label: 'Users',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.photo_camera,color: Colors.blue),
          label: 'Capture Photo',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_mail_outlined,color: Colors.blue),
          label: 'Address',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      onTap: setSelectedIndex,
      type: BottomNavigationBarType.fixed,
    );
  }
}
