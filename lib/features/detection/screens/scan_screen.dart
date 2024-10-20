import 'dart:io';
import 'package:hele/core/constants/color_constant.dart';
import 'package:hele/features/detection/models/plant_model.dart';
import 'package:hele/features/detection/screens/detail_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key, required this.title});

  final String title;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool _loading = true;
  File _image = File("");
  List _output = [];
  final picker = ImagePicker();
  bool _isDetecting = false;

  Future<List<PlantModel>?> readJsonData() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/json/model/penyakit_daun.json');
      final jsonData = json.decode(jsonString);

      List<dynamic> tanamanData = jsonData;
      List<PlantModel> tempList = [];
      for (var item in tanamanData) {
        tempList.add(PlantModel.fromJson(item));
      }
      print(tempList);
      return tempList;
    } catch (e) {
      print(e);
    }
    return null;
  }

  late Future<List<PlantModel>?> futurePlantModel;

  @override
  void initState() {
    super.initState();
    futurePlantModel = readJsonData();
    setState(() {
      _loading = true;
    });
    loadModel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    if (_isDetecting) return; // Prevent running if already detecting
    _isDetecting = true;

    try {
      var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 10, // Increase to see more labels
        threshold: 0.1, // Lower the threshold to catch more labels
      );
      print('Model Output: $output'); // Debug print to check the output

      setState(() {
        _output = output ?? [];
        _loading = false;
      });
    } catch (e) {
      print('Error during detection: $e');
      setState(() {
        _output = [];
        _loading = false;
      });
    } finally {
      _isDetecting = false; // Reset the flag after detection is complete
    }
  }

  loadModel() async {
    var res = await Tflite.loadModel(
      model: 'assets/tf/model/model76.tflite',
      labels: 'assets/tf/model/labels.txt',
    );
    print('Model loaded: $res'); // Debug print to confirm model loading
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return;

    setState(() {
      _image = File(image.path);
    });

    detectImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return;

    setState(() {
      _image = File(image.path);
    });

    detectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    print(_output.toString() + "TEST");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 30,
          title: const Text(
            "Classify",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 1.5,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: futurePlantModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: _loading
                          ? Container(
                              width: 300,
                              height: 350,
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/holder_image.png',
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    height: 50,
                                  )
                                ],
                              ),
                            )
                          : Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: 350,
                                    height: 300,
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorConstant.primaryColor
                                                .withOpacity(0.2),
                                            blurRadius: 10,
                                            offset: Offset(0, 3),
                                          ),
                                        ]),
                                    child: Image.file(
                                      _image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  _output.isEmpty
                                      ? Text(
                                          "Tidak dapat mengklasifikasikan gambar.",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 15,
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            Text(
                                              "Hasil Klasifikasi Multilable",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                                height:
                                                    10), // Jarak antara label dan hasil prediksi
                                            ..._output.map((result) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom:
                                                        10), // Jarak antara hasil prediksi
                                                child: Text(
                                                  '${result['label']} ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Visibility(
                            visible:
                                !_loading && _output.isEmpty ? false : true,
                            child: GestureDetector(
                              onTap: () {
                                _loading
                                    ? pickImage()
                                    : Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                            mapDetail: () {
                                              return snapshot.data!.elementAt(
                                                  _output[0]['index']);
                                            }(),
                                          ),
                                        ),
                                      );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 14),
                                decoration: BoxDecoration(
                                  color: ColorConstant.primaryColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  _loading ? 'Capture a Photo' : 'See Detail',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          !_loading && _output.isEmpty
                              ? Container()
                              : Text("Or"),
                          SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_loading) {
                                pickGalleryImage();
                              } else {
                                _image.delete();
                                setState(() {
                                  _loading = true;
                                });
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 14),
                              decoration: BoxDecoration(
                                color: ColorConstant.primaryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                _loading ? 'Select a Photo' : "Retry",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
