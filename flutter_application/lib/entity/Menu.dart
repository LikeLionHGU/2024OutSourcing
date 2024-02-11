class Menu {
  final String name;
  final String imageAddress;
  final int count;
  final int price;
  final String description;

  Menu({
    required this.name,
    required this.imageAddress,
    required this.count,
    required this.price,
    required this.description,
  });

  // Firestore 문서의 데이터를 받아서 Menu 객체를 생성하는 메서드
  factory Menu.fromFirestore(Map<String, dynamic> firestoreData) {
    return Menu(
      name: firestoreData['name'] ?? '', // 필드가 존재하지 않을 경우를 대비한 기본값 설정
      imageAddress: firestoreData['imageUrl'] ?? '',
      count: firestoreData['count'] is int ? firestoreData['count'] : int.tryParse(firestoreData['count'].toString()) ?? 0,
      price: firestoreData['price'] is int ? firestoreData['price'] : int.tryParse(firestoreData['price'].toString()) ?? 0,
      description: firestoreData['description'] ?? '',
    );
  }
}


