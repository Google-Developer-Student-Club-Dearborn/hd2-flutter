import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// pub.dev libraries
import 'package:hd2_app/components/bottom_navbar.dart';

import 'package:screen_brightness/screen_brightness.dart';

// splash screen
import 'package:hd2_app/components/splash_screen.dart';

// pages
import 'package:hd2_app/pages/agenda_page/agenda_page.dart';
import 'package:hd2_app/pages/information_page.dart';
import 'package:hd2_app/pages/agenda_page/navbar.dart';
import 'package:hd2_app/pages/qr_code_page/qr_code_page.dart';
import 'package:hd2_app/notification/Notification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HD2Notification.init(initScheduled: true);
  HD2Notification.showScheduledNotification(
      title: 'Test notifications',
      body: "This is what it's going to look loel",
      scheduledDate: DateTime.now().add(Duration(seconds: 15)));
  runApp(const MyApp());
}

// class MainPage extends StatefulWidget {
//   @override
//   _MainPageState createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> with ChangeNotifier {
  @override
  void initState() {
    super.initState();
    // HD2Notification.init(initScheduled: true);
    _listenForNotifications();
    // HD2Notification.showScheduledNotification(
    //     title: 'Test notifications',
    //     body: "This is what it's going to look loel",
    //     scheduledDate: DateTime.now().add(Duration(seconds: 60)));
  }

  void _listenForNotifications() {
    HD2Notification.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) => print("here");
  // Navigator.of(context).push();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _MyAppState(),
      child: MaterialApp(
        title: 'HackDearborn 2',
        theme: ThemeData(brightness: Brightness.dark),
        home: const MyHomePage(title: 'HackDearborn 2'),
      ),
    );
  }

  //TODO: store NavBar settings here
  FilterSettings _filterSettings = FilterSettings();
  int _amountOfButtons = 3;
  int _selekshun = 0;
  String _userQRString = "";

  String get userQRString => _userQRString;

  set userQRString(String userString) {
    _userQRString = userString;
    notifyListeners();
  }

  FilterSettings get filterSettings => _filterSettings;

  set filterSettings(FilterSettings value) {
    _filterSettings = value;
    notifyListeners();
  }

  List<String> get allTrues => _filterSettings.allTrues;

  set allTrues(List<String> newAllTrues) {
    _filterSettings.allTrues = newAllTrues;
    notifyListeners();
  }

  int get amountOfButtons => _amountOfButtons;

  set amountOfButtons(int newValue) {
    _amountOfButtons = newValue;
    notifyListeners();
  }

  int get selection => _selekshun;

  set selection(int newValue) {
    _selekshun = newValue;
    notifyListeners();
  }

  void setSelection(int val) {
    _selekshun = val;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;

  void _onPageChange(int pageIndex) {
    final qrDataProvider = context.read<_MyAppState>();
    setState(() {
      https: //dart.dev/diagnostics/non_type_as_type_argument
      _pageIndex = pageIndex;
    });
    bool isQrCodePage = (pageIndex == 2 && qrDataProvider._userQRString != "");
    if (isQrCodePage) {
      _setMaxBrightness();
    } else {
      _resetBrightness();
    }
  }

  void _setMaxBrightness() {
    double brightness = 1.0;
    ScreenBrightness().setScreenBrightness(brightness);
  }

  void _resetBrightness() {
    ScreenBrightness().resetScreenBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              elevation: 0,
              // backgroundColor: Colors.black,
            ),
            body: Builder(
              builder: (context) {
                switch (_pageIndex) {
                  case 0:
                    return const AgendaPage();
                  case 1:
                    return const InformationPage();
                  default:
                    return const QrCodePage();
                }
              },
            ),
            bottomNavigationBar: CustomBottomNavbar(
              pageIndex: _pageIndex,
              onTap: (index) {
                _onPageChange(index);
              },
            )),
        const SplashScreen()
      ],
    );
  }
}
