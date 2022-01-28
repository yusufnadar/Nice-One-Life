class ProductModel{

  ProductModel({this.id,this.photo,this.price,this.discountPrice,this.title,this.description,this.piece});

  String? id;
  String? photo;
  int? price;
  int? discountPrice;
  String? title;
  String? description;
  int? piece;

  factory ProductModel.fromJson(var json) => ProductModel(
    id: json['id'],
    photo: json['photo'],
    price: json['price'],
    discountPrice: json['discountPrice'],
    title: json['title'],
    piece: json['piece'],
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id':id,
    'photo':photo,
    'piece':price,
    'protein':discountPrice,
    'title':title,
    'piece':piece,
    'description':description,
  };

}