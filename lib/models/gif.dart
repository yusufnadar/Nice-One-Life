class GifModel{

  String? id;
  String? description;
  String? gif;

  GifModel({this.id,this.description,this.gif});

  factory GifModel.fromJson(Map<String,dynamic> json)=>GifModel(
    id: json['id'],
    description: json['description'],
    gif: json['gif'],
  );

  toJson()=>{
    'id':id,
    'description':description,
    'gif':gif,
  };

}