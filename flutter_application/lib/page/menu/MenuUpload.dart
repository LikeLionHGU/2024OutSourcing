import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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


  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // 선택한 이미지로 _image를 업데이트
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> options = ['메인', '찌개', '해물', '육류', '반찬'];

    return Scaffold(
      appBar: AppBar(
        title: Text("메뉴 작성"),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
            Divider(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.05,
              child: TextField(
                controller: nameController,
                cursorColor: Colors.black,
                style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
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
                style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
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
                style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                Text("카테고리", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 버튼들 사이에 동일한 공간 배분
              children: List<Widget>.generate(
                options.length,
                    (index) {
                  return ChoiceChip(
                    selectedColor: Colors.grey,
                    backgroundColor: Colors.white,
                    showCheckmark: false,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0),
                      side: BorderSide(color: _selectedIndex == index ? Colors.grey : Colors.grey),
                    ),
                    // 선택되었을 때와 선택되지 않았을 때 동일한 텍스트 스타일을 유지하기 위한 스타일링
                    labelStyle: TextStyle(
                      color: _selectedIndex == index ? Colors.white : Colors.black,
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.025,),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.18,
              child: TextField(
                minLines: 5,
                maxLines: 5,
                controller: descriptionController,
                cursorColor: Colors.black,
                style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '상품설명을 입력해주세요',
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
                style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    // 포커스가 맞춰졌을 때의 테두리 색상을 설정
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  hintText: '배송안내를 입력해주세요',
                  border: OutlineInputBorder(),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
