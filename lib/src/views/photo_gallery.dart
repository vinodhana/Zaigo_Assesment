import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({Key? key}) : super(key: key);

  @override
  _PhotoGalleryScreenState createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<File> imageStorage = [];
  List<Asset> imagePicker = [];
  String sError = 'No Error Dectected';

  bool isLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    getFilePath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0.1,
        automaticallyImplyLeading: false,
        title: Text(
          'Capture Photo',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: imageStorage.length + 1,
                  itemBuilder: (context, index) {
                    return index >= imageStorage.length
                        ? Padding(
                            padding:
                                const EdgeInsets.only(left: 200, right: 200),
                            child: InkWell(
                              onTap: () {
                                loadImage();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Colors.redAccent),
                                child: Center(
                                  child: (isLoad == true)
                                      ? const CircularProgressIndicator(
                                          backgroundColor: Colors.orangeAccent,
                                        )
                                      : const Text(
                                          "Load Image",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 25),
                                        ),
                                ),
                              ),
                            ),
                          )
                        : Image.file(imageStorage[index]);
                  }),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          File? file= await captureAndSaveImage();
          Directory _localPath = await getApplicationDocumentsDirectory();
          debugPrint('Directory path ' + _localPath.path);
          await file!.create(recursive: true);
          Uint8List bytes = await file.readAsBytes();
          await file.writeAsBytes(bytes);
          debugPrint('FIle details' + file.path.toString());
          //showModalForm(context);
        },
        tooltip: "Add",
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }

  Future<String> getFilePath() async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/demoTextFile.txt'; // 3
debugPrint('appDocumentsPath + '+ appDocumentsPath.toString());
    return filePath;
  }
  Future<File?> captureAndSaveImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedImage == null) return null;

    try {
      final directory = await getExternalStorageDirectory();
      final rand = Random();
      int val = rand.nextInt(500);
      if (directory != null) return File(pickedImage.path).copy('${directory.path}/image${val}.png');

    } catch (e) {
      return null;
    }
  }

  loadImage() async {
    setState(() {
      isLoad = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    Directory path = await getApplicationDocumentsDirectory();
    setState(() {
      for (int i = 1; i < 3; i++) {
        String pathFile = path.path;
        String fileName = '$pathFile/img-' + i.toString() + '.png';
        File tempFile = File(fileName);
        imageStorage.add(tempFile);
      }
      isLoad = false;
    });

    return true;
  }

  void showModalForm(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateModal) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: Column(
                  children: [
                    const Center(
                        child: Text(
                      "Upload Image",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                    const Divider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.orangeAccent,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Pick images",
                      ),
                      onPressed: () async {
                        var res = await loadAssets();
                        setStateModal(() {
                          imagePicker = res;
                          sError = "";
                        });
                      },
                    ),
                    Expanded(
                      child: showImages(context),
                    ),
                    MaterialButton(
                      onPressed: () {
                        save();
                      },
                      textColor: Colors.white,
                      color: Colors.red,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Save",
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Future<List<Asset>> loadAssets() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 2,
        enableCamera: true,
        selectedAssets: imagePicker,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Image Example",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      sError = e.toString();
    }

    // if (!mounted) return null;

    setState(() {
      imagePicker = resultList;
      sError = 'No Error Dectected';
    });

    return resultList;
  }

  void save() async {
    int i = 1;
    imagePicker.forEach((imageAsset) async {


      final appDocDir = await getExternalStorageDirectory();
      String appDocPath = appDocDir!.path;
      debugPrint("appDocPath   "+appDocPath);
      final file = await getImageFileFromAsset(appDocPath);
      Directory path = await getApplicationDocumentsDirectory();
      String pathUpload = path.path;
      String fileName = '$pathUpload/img-' + i.toString() + '.png';
      i++;
      await file.copy(fileName);
    });

    Navigator.of(context).pop();
    // _scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text('Yay! Upload success!')));
  }

  getImageFileFromAsset(String path) async {
    return File(path);
  }

  Widget showImages(BuildContext context) {
    return GridView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: List.generate(
        imagePicker.length,
        (index) {
          Asset asset = imagePicker[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, left: 5, right: 5, bottom: 5),
                    child: AssetThumb(
                      asset: asset,
                      width: 300,
                      height: 300,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 15.0,
        childAspectRatio: 1.0,
      ),
    );
  }
}
