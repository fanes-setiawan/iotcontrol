import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:flutter/foundation.dart';

class QImagePicker extends StatefulWidget {
  final String label;
  final String? value;
  final String? hint;
  final String Function(String?)? validator;
  final bool obscure;
  final Function(String) onChanged;
  final String? provider;

  const QImagePicker(
      {Key? key,
      required this.label,
      this.value,
      this.hint,
      this.validator,
      this.obscure = false,
      required this.onChanged,
      this.provider = "cloudinary"})
      : super(key: key);

  @override
  State<QImagePicker> createState() => _QImagePickerState();
}

class _QImagePickerState extends State<QImagePicker> {
  String? imageUrl;
  bool loading = false;
  late TextEditingController controller;
  @override
  void initState() {
    imageUrl = widget.value;
    controller = TextEditingController(
      text: widget.value ?? "_",
    );
    super.initState();
  }

  Future<String?> getFileMultiplePlatfrom() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        "png",
        "jpg",
      ],
      allowMultiple: false,
    );
    if (result == null) return null;
    return result.files.first.path;
  }

  Future<String?> getFileAndroidIosAndweb() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    String? filePath = image?.path;
    if (filePath == null) return null;
    return filePath;
  }

  Future<String?> uploadFile(String filePath) async {
    if (widget.provider == "cloudinary") {
      return await uploadToCloudinary(filePath);
    }
    return await uploadToImgBB(filePath);
  }

  Future<String> uploadToImgBB(String filePath) async {
    final formData = FormData.fromMap({
      'image': MultipartFile.fromBytes(
        File(filePath).readAsBytesSync(),
        filename: "upload.jpg",
      )
    });
    var res = await Dio().post(
      "https://api.imgbb.com/1/upload?key=1018863e0712f31d3014187b02745fb4",
      data: formData,
    );
    var data = res.data["data"];
    var url = data["url"];
    widget.onChanged(url);
    return url;
  }

  Future<String> uploadToCloudinary(String filePath) async {
    String cloudName = "dlkwckjvt";
    String apiKey = "581349388592411";
    String apiSecret = "b2ogwmbNvOG6CF3FrQlFOJDvbH4";

    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        File(filePath).readAsBytesSync(),
        filename: "upload.jpg",
      ),
      'upload_preset': 'ozik5iy7',
      'api_key': apiKey,
    });

    var res = await Dio().post(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
      data: formData,
    );
    String url = res.data["secure_url"];
    return url;
  }

  browsePhoto() async {
    if (loading) return;

    String? filePath;
    loading = true;
    setState(() {});
    if (!kIsWeb && Platform.isWindows) {
      filePath = await getFileMultiplePlatfrom();
    } else {
      filePath = await getFileAndroidIosAndweb();
    }
    if (filePath == null) return;
    imageUrl = await uploadFile(filePath);

    loading = false;

    if (imageUrl != null) {
      widget.onChanged(imageUrl!);
      controller.text = imageUrl!;
    }
    setState(() {});
  }

  String? get currentValue {
    return imageUrl;
  }

  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  decoration: BoxDecoration(
                    color: loading ? Colors.blueGrey[900] : Colors.white,
                    image: loading
                        ? null
                        : DecorationImage(
                            image: NetworkImage(
                              imageUrl == null
                                  ? 'https://e7.pngegg.com/pngimages/282/256/png-clipart-user-profile-avatar-computer-icons-google-account-black-accounting.png'
                                  : imageUrl!,
                            ),
                            fit: BoxFit.cover),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                  child: Visibility(
                    visible: loading == true,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: CircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "Uploading...",
                            style: TextStyle(
                              fontSize: 9.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: loading ? Colors.grey : Colors.blue.shade800,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () => browsePhoto(),
                        icon: Icon(Icons.edit, size: 17, color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
