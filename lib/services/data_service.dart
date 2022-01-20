import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:new_one_life/controllers/user_controller.dart';
import 'package:new_one_life/default/behavior.dart';
import 'package:new_one_life/models/gif.dart';
import 'package:new_one_life/models/package.dart';
import 'package:new_one_life/models/post.dart';
import 'package:new_one_life/models/product.dart';
import 'package:new_one_life/models/protein_value.dart';
import 'package:new_one_life/models/user.dart';
import 'package:new_one_life/ui/drawer_pages/doctors.dart';
import 'package:new_one_life/ui/home/home_page.dart';

class DataService{

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  int perPagePost = 10;
  int perPageDoctor = 10;
  int perPageProduct = 10;
  DocumentSnapshot? _lastDocumentForPost;
  DocumentSnapshot? _lastDocumentForDoctors;
  DocumentSnapshot? _lastDocumentForProduct;

  Future getPosts() async{
    RxList<PostModel> postModel = RxList<PostModel>();
    var snapshot = await _firestore.collection('posts').orderBy('createdAt',descending: true).limit(perPagePost).get();
    for(var item in snapshot.docs){
      var snapshot1 = await _firestore.collection('users').doc(item.data()['userId']).get();
      var ourMap = Map<String, dynamic>.from(item.data());
      ourMap.putIfAbsent('name', () => snapshot1.data()!['name']);
      ourMap.putIfAbsent('userPhoto', () => snapshot1.data()!['userPhoto']);
      postModel.add(PostModel.fromJson(ourMap));
    }
    if(snapshot.docs.isNotEmpty){
      _lastDocumentForPost = snapshot.docs[snapshot.docs.length-1];
    }
    return postModel;
  }

  Future getMorePosts()async{
    RxList<PostModel> postModel = RxList<PostModel>();
    var snapshot = await _firestore.collection('posts').orderBy('createdAt',descending: true).startAfterDocument(_lastDocumentForPost!).limit(perPagePost).get();
    for(var item in snapshot.docs){
      var snapshot1 = await _firestore.collection('users').doc(item.data()['userId']).get();
      var ourMap = Map<String, dynamic>.from(item.data());
      ourMap.putIfAbsent('name', () => snapshot1.data()!['name']);
      ourMap.putIfAbsent('userPhoto', () => snapshot1.data()!['userPhoto']);
      postModel.add(PostModel.fromJson(ourMap));
    }
    if(snapshot.docs.length < perPagePost){
      Get.find<HomePageController>().setgetMore = false;
    }else{
      _lastDocumentForPost = snapshot.docs[snapshot.docs.length-1];
    }
    return postModel;
  }

  Future getDoctors() async{
    RxList<UserModel> doctors = RxList<UserModel>();
    var snapshot = await _firestore.collection('users').where('isDoctor',isEqualTo: true,).where('id',isNotEqualTo: Get.find<UserController>().user.id).limit(perPageDoctor).get();
    for(var item in snapshot.docs){
      doctors.add(UserModel.fromJson(item.data()));
    }
    if(snapshot.docs.isNotEmpty){
      _lastDocumentForDoctors = snapshot.docs[snapshot.docs.length-1];
    }
    return doctors;
  }

  Future getMoreDoctors() async{
    RxList<UserModel> doctors = RxList<UserModel>();
    var snapshot = await _firestore.collection('users').where('isDoctor',isEqualTo: true).startAfterDocument(_lastDocumentForDoctors!).limit(perPagePost).get();
    for(var item in snapshot.docs){
      doctors.add(UserModel.fromJson(item.data()));
    }
    if(snapshot.docs.length < perPageDoctor){
      Get.find<DoctorsController>().setgetMore = false;
    }else{
      _lastDocumentForDoctors = snapshot.docs[snapshot.docs.length-1];
    }
    return doctors;
  }

  Future getProteinValues() async{
    RxList<ProteinValueModel> proteinValues = RxList<ProteinValueModel>();
    var snapshot = await _firestore.collection('protein_values').get();
    for(var item in snapshot.docs){
      proteinValues.add(ProteinValueModel.fromJson(item.data()));
    }
    return proteinValues;
  }

  getPrivacyPolicy() async{
    var snapshot = await _firestore.collection('agreements').doc('privacy').get();
    return snapshot.data()!['privacy'];
  }

  getDistanceSelling() async{
    var snapshot = await _firestore.collection('agreements').doc('distanceSelling').get();
    return snapshot.data()!['distanceSelling'];
  }

  Future<List<ProductModel>> getProducts() async{
    RxList<ProductModel> products = RxList<ProductModel>();
    var snapshot = await _firestore.collection('products').orderBy('discountPrice').limit(perPageProduct).get();
    for(var item in snapshot.docs){
      products.add(ProductModel.fromJson(item.data()));
    }
    if(snapshot.docs.isNotEmpty){
      _lastDocumentForProduct = snapshot.docs[snapshot.docs.length-1];
    }
    return products;
  }

  getProductDetail(productId) async{
    var snapshot = await _firestore.collection('products').doc(productId).get();
    return ProductModel.fromJson(snapshot.data());
  }

  Future<List<PackageModel>> getPackages() async{
    RxList<PackageModel> packages = RxList<PackageModel>();
    var snapshot = await _firestore.collection('packages').get();
    for(var item in snapshot.docs){
      packages.add(PackageModel.fromJson(item.data()));
    }
    if(snapshot.docs.isNotEmpty){
      _lastDocumentForProduct = snapshot.docs[snapshot.docs.length-1];
    }
    return packages;
  }

  Future<List<GifModel>> getGifs(id) async{
    RxList<GifModel> gifs = RxList<GifModel>();
    var snapshot = await _firestore.collection('packages').doc(id).collection('gifs').get();
    for(var item in snapshot.docs){
      gifs.add(GifModel.fromJson(item.data()));
    }
    if(snapshot.docs.isNotEmpty){
      _lastDocumentForProduct = snapshot.docs[snapshot.docs.length-1];
    }
    return gifs;
  }

  Future<List<String>> getMyPackages() async{
    var liste = <String>[];
    var snapshot = await _firestore.collection('users').doc(userId).get();
    for(String item in snapshot.data()!['packages']){
      liste.add(item);
    }
    return liste;
  }
  
}