class Product {
  late String title, thumbnail, description;
  late double price;

  Product();
  Product.fromJSON(Map<String,dynamic> item){
    title=item["title"];
    thumbnail=item["thumbnail"];
    price=item["price"];
    description=item["description"];
  }
}
