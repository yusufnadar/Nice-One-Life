import 'package:get/get.dart';
import 'package:new_one_life/models/gif.dart';
import 'package:new_one_life/models/package.dart';
import 'package:new_one_life/models/post.dart';
import 'package:new_one_life/models/product.dart';
import 'package:new_one_life/models/protein_value.dart';
import 'package:new_one_life/models/user.dart';
import 'package:new_one_life/services/data_service.dart';
import 'package:new_one_life/services/notification_service/notification.dart';
import 'package:new_one_life/ui/drawer_pages/agreements/distance_selling.dart';
import 'package:new_one_life/ui/drawer_pages/agreements/privacy.dart';
import 'package:new_one_life/ui/drawer_pages/doctors.dart';
import 'package:new_one_life/ui/drawer_pages/proteins.dart';
import 'package:new_one_life/ui/home/home_page.dart';

class DataController extends GetxController{
  DataService _dataService = DataService();

  RxList<PostModel> _posts = <PostModel>[].obs;
  List<PostModel>? get posts => _posts.value;
  set setPosts(List<PostModel> post) => _posts.value = post;

  RxList<UserModel> _doctors = <UserModel>[].obs;
  List<UserModel>? get doctors => _doctors.value;
  set setDoctors(List<UserModel> doctor) => _doctors.value = doctor;

  RxList<ProteinValueModel> _proteinValues = <ProteinValueModel>[].obs;
  List<ProteinValueModel>? get proteinValues => _proteinValues.value;
  set setProteinValues(List<ProteinValueModel> proteinValues) => _proteinValues.value = proteinValues;

  RxList<ProductModel> _products = <ProductModel>[].obs;
  List<ProductModel>? get products => _products.value;
  set setProducts(List<ProductModel> product) => _products.value = product;

  Rx<ProductModel> _product = ProductModel().obs;
  ProductModel get product => _product.value;
  set setProduct(ProductModel product) => _product.value = product;

  RxList<PackageModel> _packages = <PackageModel>[].obs;
  List<PackageModel>? get packages => _packages.value;
  set setPackages(List<PackageModel> package) => _packages.value = package;

  RxList<String> _myPackages = <String>[].obs;
  List<String>? get myPackages => _myPackages.value;
  set setMyPackages(List<String> package) => _myPackages.value = package;

  RxList<GifModel> _gifs = <GifModel>[].obs;
  List<GifModel>? get gifs => _gifs.value;
  set setGifs(List<GifModel> gif) => _gifs.value = gif;

  @override
  void onInit() {
    FirebaseNotifications().setupFirebase();
    FirebaseNotifications().afterClickNotification();
    super.onInit();
  }

  Future getPosts()async{
    try{
      Get.find<HomePageController>().setisLoading = true;
      var postlar = await _dataService.getPosts();
      if(postlar != null){
        setPosts = [];
        setPosts= postlar;
      }
    }catch(e){
      Get.find<HomePageController>().setisLoading = false;
    }finally{
      Get.find<HomePageController>().setisLoading = false;
    }
  }

  Future getMorePosts()async{
    posts!.addAll(await _dataService.getMorePosts());
  }

  Future getDoctors() async{
    try{
      Get.find<DoctorsController>().setisLoading = true;
      var doktorlar = await _dataService.getDoctors();
      if(doktorlar != null){
        setDoctors = doktorlar;
      }
    }catch(e){
      Get.snackbar('Error', e.toString());
      Get.find<DoctorsController>().setisLoading = false;
    }finally{
      Get.find<DoctorsController>().setisLoading = false;
    }
  }

  getMoreDoctors() async{
    doctors!.addAll(await _dataService.getMoreDoctors());
  }

  Future getProteinValues() async{
    try{
      Get.find<ProteinsController>().setisLoading = true;
      var proteinDegerleri = await _dataService.getProteinValues();
      if(proteinDegerleri != null){
        setProteinValues = proteinDegerleri;
      }
    }catch(e){
      Get.find<ProteinsController>().setisLoading = false;
    }finally{
      Get.find<ProteinsController>().setisLoading = false;
    }
  }

  void getPrivacyPolicy() async{
    try{
      Get.find<PrivacyController>().setPrivacy = await _dataService.getPrivacyPolicy();
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }

  void getDistanceSelling() async{
    try{
      Get.find<DistanceCellingController>().setDistanceSelling = await _dataService.getDistanceSelling();
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }

  void getProducts() async{
    try{
      var urunler = await _dataService.getProducts();
      if(urunler != null){
        setProducts = urunler;
      }
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }

  void getProductDetail(productId) async{
    try{
      var urun = await _dataService.getProductDetail(productId);
      if(urun != null){
        setProduct = urun;
      }
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }

  void getPackages() async{
    try{
      var paketler = await _dataService.getPackages();
      if(paketler != null){
        setPackages = paketler;
      }
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }

  void getGifs(id) async{
    try{
      var gifler = await _dataService.getGifs(id);
      if(gifler != null){
        setGifs = gifler;
      }
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }

  void getMyPackages() async{
    try{
      var myPackages = await _dataService.getMyPackages();
      if(myPackages != null){
        setMyPackages = myPackages;
      }
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }
}