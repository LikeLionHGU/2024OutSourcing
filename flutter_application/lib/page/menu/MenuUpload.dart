import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../RouterPage.dart';

class MenuUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MenuUploadState();
}

class MenuUploadState extends State<MenuUpload> {
  File? _image;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  int _selectedIndex = 0;
  late String fileName;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // 선택한 이미지로 _image를 업데이트
      });
    }
  }

  Future<String?> uploadImage(File image) async {
    try {
      fileName =
          'images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg';
      firebase_storage.UploadTask task = firebase_storage
          .FirebaseStorage.instance
          .ref(fileName)
          .putFile(image);

      firebase_storage.TaskSnapshot snapshot = await task;
      if (snapshot.state == firebase_storage.TaskState.success) {
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        return downloadUrl;
      }
    } catch (e) {
      print(e); // 에러 출력
      return null;
    }
  }

  Future<void> saveData(String imageUrl) async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    return products
        .add({
          'name': nameController.text,
          'price': int.tryParse(priceController.text) ?? 0,
          'count': int.tryParse(countController.text) ?? 0,
          'description': descriptionController.text,
          'address': addressController.text,
          'categoryIndex': _selectedIndex,
          'imageUrl': imageUrl, // 업로드된 이미지의 URL
          'imagePath': fileName
        })
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add product: $error"));
  }

  void uploadAndSaveData() {
    if (_image != null) {
      uploadImage(_image!).then((imageUrl) {
        if (imageUrl != null) {
          if (nameController.text == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('업로드 실패'),
                  backgroundColor: Colors.white,
                  content: Text('메뉴 이름을 입력해주세요.'),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // 경고창을 닫습니다.
                      },
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    // 이 부분을 추가합니다.
                    borderRadius: BorderRadius.circular(10.0), // 모서리의 둥근 정도를 조절
                    side: BorderSide(
                      // 테두리의 두께와 색상을 조절
                      color: Colors.white, // 테두리 색상
                      width: 1, // 테두리 두께
                    ),
                  ),
                );
              },
            );
          } else if (priceController.text == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('업로드 실패'),
                  backgroundColor: Colors.white,
                  content: Text('가격을 입력해주세요.'),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // 경고창을 닫습니다.
                      },
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    // 이 부분을 추가합니다.
                    borderRadius: BorderRadius.circular(10.0), // 모서리의 둥근 정도를 조절
                    side: BorderSide(
                      // 테두리의 두께와 색상을 조절
                      color: Colors.white, // 테두리 색상
                      width: 1, // 테두리 두께
                    ),
                  ),
                );
              },
            );
          } else if (countController.text == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('업로드 실패'),
                  backgroundColor: Colors.white,
                  content: Text('수량을 입력해주세요.'),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // 경고창을 닫습니다.
                      },
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    // 이 부분을 추가합니다.
                    borderRadius: BorderRadius.circular(10.0), // 모서리의 둥근 정도를 조절
                    side: BorderSide(
                      // 테두리의 두께와 색상을 조절
                      color: Colors.white, // 테두리 색상
                      width: 1, // 테두리 두께
                    ),
                  ),
                );
              },
            );
          } else if (descriptionController.text == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('업로드 실패'),
                  backgroundColor: Colors.white,
                  content: Text('상품 설명을 입력해주세요.'),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // 경고창을 닫습니다.
                      },
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    // 이 부분을 추가합니다.
                    borderRadius: BorderRadius.circular(10.0), // 모서리의 둥근 정도를 조절
                    side: BorderSide(
                      // 테두리의 두께와 색상을 조절
                      color: Colors.white, // 테두리 색상
                      width: 1, // 테두리 두께
                    ),
                  ),
                );
              },
            );
          } else if (addressController.text == null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('업로드 실패'),
                  backgroundColor: Colors.white,
                  content: Text('배송 안내사항을 입력해주세요.'),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // 경고창을 닫습니다.
                      },
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    // 이 부분을 추가합니다.
                    borderRadius: BorderRadius.circular(10.0), // 모서리의 둥근 정도를 조절
                    side: BorderSide(
                      // 테두리의 두께와 색상을 조절
                      color: Colors.white, // 테두리 색상
                      width: 1, // 테두리 두께
                    ),
                  ),
                );
              },
            );
          } else {
            saveData(imageUrl);

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('업로드 성공'),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  content: Text('메뉴가 업로드 되었습니다.'),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        '확인',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          _image = null;
                          nameController.text = '';
                          priceController.text = '';
                          countController.text = '';
                          descriptionController.text = '';
                          addressController.text = '';
                        });
                        Navigator.of(context).pop(); // 경고창을 닫습니다.
                      },
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    // 이 부분을 추가합니다.
                    borderRadius: BorderRadius.circular(10.0), // 모서리의 둥근 정도를 조절
                    side: BorderSide(
                      // 테두리의 두께와 색상을 조절
                      color: Colors.white, // 테두리 색상
                      width: 1, // 테두리 두께
                    ),
                  ),
                );
              },
            );
          }
        }
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('업로드 실패'),
            backgroundColor: Colors.white,
            content: Text('이미지를 선택하지 않았습니다. 이미지를 선택해주세요.'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  '확인',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // 경고창을 닫습니다.
                },
              ),
            ],
            shape: RoundedRectangleBorder(
              // 이 부분을 추가합니다.
              borderRadius: BorderRadius.circular(10.0), // 모서리의 둥근 정도를 조절
              side: BorderSide(
                // 테두리의 두께와 색상을 조절
                color: Colors.white, // 테두리 색상
                width: 1, // 테두리 두께
              ),
            ),
            elevation: 0,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> options = ['조림', '나물', '국', '고기', '기타'];

    return Scaffold(
      appBar: AppBar(
        title: Text("메뉴 작성"),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _image != null
                    ? Image.file(_image!,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.2)
                    : Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // 테두리 색상
                          borderRadius: BorderRadius.circular(1), // 모서리 둥글기
                        ),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt_outlined),
                          onPressed: () {
                            _pickImage();
                          },
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Divider(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextField(
                controller: nameController,
                cursorColor: Colors.black,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '메뉴',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '메뉴 이름 입력해주세요',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                controller: priceController,
                cursorColor: Colors.black,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '판매 가격',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '판매 가격을 입력해주세요',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                controller: countController,
                cursorColor: Colors.black,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelText: '수량',
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '수량을 입력해주세요',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Text(
                  "카테고리",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // 버튼들 사이에 동일한 공간 배분
              children: List<Widget>.generate(
                options.length,
                (index) {
                  return ChoiceChip(
                    selectedColor: Color(0xffFF8B51),
                    backgroundColor: Color(0xffebebeb),
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                      side: BorderSide(
                          color: _selectedIndex == index
                              ? Color(0xffFF8B51)
                              : Color(0xffebebeb)),
                    ),
                    // 선택되었을 때와 선택되지 않았을 때 동일한 텍스트 스타일을 유지하기 위한 스타일링
                    labelStyle: TextStyle(
                      color:
                          _selectedIndex == index ? Colors.white : Colors.black,
                    ),
                    label: Text(options[index]),
                    selected: _selectedIndex == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedIndex = selected ? index : 0;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.18,
              child: TextField(
                minLines: 5,
                maxLines: 5,
                controller: descriptionController,
                cursorColor: Colors.black,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  fillColor: Color(0xffebebeb),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Color(0xffebebeb)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Color(0xffebebeb)),
                  ),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '상품설명을 입력해주세요',
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.038),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.18,
              child: TextField(
                minLines: 5,
                maxLines: 5,
                controller: addressController,
                cursorColor: Colors.black,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Color(0xffebebeb)),
                  ),
                  fillColor: Color(0xffebebeb),
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Color(0xffebebeb)),
                  ),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '배송안내를 입력해주세요',
                  hintStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.038),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Color(0xffFF8B51),
                  border: Border.all(color: Color(0xffFF8B51)), // 테두리 색상
                  borderRadius: BorderRadius.circular(8), // 모서리 둥글기
                ),
                child: TextButton(
                  child: Text(
                    "등록하기",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    uploadAndSaveData();
                  },
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            )
          ],
        ),
      ),
    );
  }
}

// 김치찌개
// 이건 김치찌개입니다.
// 배송해주세용
