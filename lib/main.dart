import 'dart:io';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:new_one_life/default/behavior.dart';
import 'package:new_one_life/default/initialize/notification_initialize.dart';
import 'package:new_one_life/default/theme.dart';
import 'package:new_one_life/ui/home/home_page.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initialize.initializing();
  initializeDateFormatting('tr');
  HttpOverrides.global = MyHttpOverrides();
  String link = 'https://newonelife.page.link/wtQ4';

  //final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getDynamicLink(Uri.parse(link));

  final PendingDynamicLinkData? data =
  await FirebaseDynamicLinks.instance.getInitialLink();
  final Uri? deepLink = data?.link;
   print(deepLink);
 /*
  print('deepLink ${initialLink?.link}');
  print(initialLink?.link.toString().split('/')[3]);
  */
  runApp(MyApp(deeplink: deepLink,));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  var deeplink;

  MyApp({Key? key, this.deeplink});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Nice One Life',
      builder: (context, child) =>
          ScrollConfiguration(behavior: MyBehavior(), child: child!),
      debugShowCheckedModeBanner: false,
      //initialBinding: AllBindings(),
      theme: ThemeDatas.themeData(),
      locale: Get.deviceLocale,
      //initialRoute: '/',
      home: deeplink != null ? HomePage() : const TestPage(),
      getPages: [
        GetPage(name: '/home_page', page: () => HomePage()),
        //GetPage(name: '/', page: () => LandingPage())
      ],
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {


  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final String Link = 'https://newonelife.page.link';

  void initDynamicLinks() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      print('dynamicLinkData $dynamicLinkData');

      print('deepLink ${dynamicLinkData.link}');
      print(dynamicLinkData.link.toString().split('/')[3]);
      //Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }


  Future<void>

  _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://newonelife.page.link',
      link: Uri.parse(Link+'/selam'),
      androidParameters: const AndroidParameters(
        packageName: 'com.newOneLife.new_one_life',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.newOneLife.new_one_life',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
      await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  bool _isCreatingLink = false;
  String? _linkMessage;



  final String _testString =
      'To test: long press link and then copy and click from a non-browser '
      "app. Make sure this isn't being tested on iOS simulator and iOS xcode "
      'is properly setup. Look at firebase_dynamic_links/README.md for more '
      'details.';

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Links Example'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () async {
                          final PendingDynamicLinkData? data =
                          await dynamicLinks.getInitialLink();
                          final Uri? deepLink = data?.link;

                          if (deepLink != null) {
                            // ignore: unawaited_futures
                            print('deep link null değil');
                            //Navigator.pushNamed(context, deepLink.path);
                          }else{
                            print('deep link null');
                          }
                        },
                        child: const Text('getInitialLink'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final PendingDynamicLinkData? data =
                          await dynamicLinks
                              .getDynamicLink(Uri.parse('https://newonelife.page.link/wtQ4'));
                          final Uri? deepLink = data?.link;

                          if (deepLink != null) {
                            // ignore: unawaited_futures
                            print(deepLink);
                            print('deeplink 2.kısımda null değil');
                            //Navigator.pushNamed(context, deepLink.path);
                          }else{
                            print('deeplink 2.kısımda null');
                          }
                        },
                        child: const Text('getDynamicLink'),
                      ),
                      ElevatedButton(
                        onPressed: !_isCreatingLink
                            ? () => _createDynamicLink(false)
                            : null,
                        child: const Text('Get Long Link'),
                      ),
                      ElevatedButton(
                        onPressed: !_isCreatingLink
                            ? () => _createDynamicLink(true)
                            : null,
                        child: const Text('Get Short Link'),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      if (_linkMessage != null) {
                        print(_linkMessage);
                        await launch(_linkMessage!);
                      }
                    },
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: _linkMessage));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Copied Link!')),
                      );
                    },
                    child: Text(
                      _linkMessage ?? '',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                  Text(_linkMessage == null ? '' : _testString)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

