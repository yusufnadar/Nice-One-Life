class PackageModel{

  var id;
  var photo;
  int? price;
  var title;
  int? discountPrice;
  var altPhoto;
  var description;

  PackageModel({this.id,this.photo,this.price,this.title,this.description,this.discountPrice,this.altPhoto});

  factory PackageModel.fromJson(Map<String,dynamic> json)=>PackageModel(
    id: json['id'],
    photo: json['photo'],
    title: json['title'],
    price: json['price'],
    discountPrice: json['discountPrice'],
    altPhoto: json['altPhoto'],
    description: json['description'],
  );

  toJson()=>{
    'id':id,
    'photo':photo,
    'title':title,
    'price':price,
    'discountPrice':discountPrice,
    'altPhoto':altPhoto,
    'description':description,
  };

}