class ProteinValueModel{


  ProteinValueModel({this.id,this.photo,this.piece,this.protein,this.title});

  String? id;
  String? photo;
  String? piece;
  String? protein;
  String? title;

  factory ProteinValueModel.fromJson(var json) => ProteinValueModel(
    id: json['id'],
    photo: json['photo'],
    piece: json['piece'],
    protein: json['protein'],
    title: json['title'],
  );

  Map<String, dynamic> toJson() => {
    'id':id,
    'photo':photo,
    'piece':piece,
    'protein':protein,
    'title':title,
  };

}