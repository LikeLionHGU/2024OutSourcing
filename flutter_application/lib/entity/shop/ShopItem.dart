class ShopItem {
  String name;
  int price;
  int count;
  String imageAddress;
  bool isSelected;
  String documentId;

  ShopItem(
      {required this.name,
        required this.documentId,
        required this.price,
        required this.count,
        required this.isSelected,
        required this.imageAddress});

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'price' : price,
      'count' : count,
      'imageAddress' : imageAddress
    };
  }

  factory ShopItem.fromMap(Map<String, dynamic> map) {
    return ShopItem(
      documentId: "",
      name: map['name'],
      price: map['price'],
      count: map['count'],
      imageAddress: map['imageAddress'],
      isSelected: false,
    );
  }
}
