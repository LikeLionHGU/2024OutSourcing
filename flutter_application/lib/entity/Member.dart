import 'package:cloud_firestore/cloud_firestore.dart';
class Member {
  String name;
  String email;
  String phoneNumber;
  String address;
  String addressDetail;

  Member(
      {required this.name,
        required this.email,
        required this.phoneNumber,
        required this.address,
        required this.addressDetail});

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'phoneNumber' : phoneNumber,
      'address' : address,
      'addressDetail' : addressDetail
    };
  }

  factory Member.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Member(
      email: data['email'] as String,
      name: data['name'] as String,
      phoneNumber: data['phoneNumber'] as String,
      address: data['address'] as String,
      addressDetail: data['addressDetail'] as String,
    );
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      addressDetail: map['addressDetail'],
      email: map['email'],
    );
  }

  // factory Student.fromMap(Map<String, dynamic> data) {
  //   return Student(
  //     email: data['email'] as String? ?? 'default@email.com',
  //     name: data['name'] as String? ?? 'Default Name',
  //     uid: data['uid'] as String? ?? 'Default UID',
  //     studentId: data['studentId'] as String? ?? 'Default Student ID',
  //     major: data['major'] as String? ?? 'Default Major',
  //     MBTI: data['MBTI'] as String? ?? 'Default MBTI',
  //     imagePath: data['imagePath'] as String? ?? 'default/image/path',
  //   );
  // }
}

