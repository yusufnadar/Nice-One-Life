class AddressModel{

  String? id;
  String? address;
  String? addressName;
  String? city;
  String? name;
  String? surname;
  String? phoneNumber;

  AddressModel({this.id,this.name,this.address,this.addressName,this.city,this.surname,this.phoneNumber});

  factory AddressModel.fromJson(Map<String,dynamic> json)=>AddressModel(
    id: json['id'],
    address: json['address'],
    addressName: json['addressName'],
    city: json['city'],
    name: json['name'],
    phoneNumber: json['phoneNumber'],
    surname: json['surname'],
  );

  toJson()=>{
    'id':id,
    'address':address,
    'addressName':addressName,
    'city':city,
    'name':name,
    'phoneNumber':phoneNumber,
    'surname':surname,
  };

}