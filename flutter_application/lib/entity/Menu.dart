class Menu {
  String name;
  int price;
  int count;
  String imageAddress;

  Menu(
      {required this.name,
      required this.price,
      required this.count,
      required this.imageAddress});

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'price' : price,
      'count' : count,
      'imageAddress' : imageAddress
    };
  }
}
