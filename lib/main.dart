import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicine_reminder/dao/medicine_dao.dart';
import 'package:medicine_reminder/dao/reminder_check_dao.dart';
import 'package:medicine_reminder/dao/reminder_dao.dart';
import 'package:medicine_reminder/database.dart';
import 'package:medicine_reminder/entities/medicine.dart';
import 'package:medicine_reminder/pages/Home/home.dart';
import 'package:medicine_reminder/pages/cabinet/cabinet.dart';
import 'package:medicine_reminder/pages/calender/calender.dart';
import 'package:medicine_reminder/pages/landing/landing1.dart';
import 'package:medicine_reminder/pages/landing/landing2.dart';
import 'package:medicine_reminder/pages/landing/landing3.dart';
import 'package:medicine_reminder/pages/medicineAddPage/medicineAddPage.dart';
import 'package:medicine_reminder/pages/medicineEditPage/medicineEditPage.dart';
import 'package:medicine_reminder/pages/medicineItemPage/medicineItemPage.dart';
import 'package:medicine_reminder/pages/reminderAddPage/reminderAddPage.dart';
import 'package:medicine_reminder/pages/splash/splash.dart';
import 'package:medicine_reminder/theme.dart';
import 'package:medicine_reminder/util/notificationUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_gen/gen_l10n/app_localization.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future onSelectNotification(payload) async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final route = payload.toString().split(" ")[0];
  final value = payload.toString().split(" ")[1];
  if (route == 'medicine') {
    final medicineDao = database.medicineDao;
    Medicine? med = await medicineDao.findMedicineById(int.parse(value));
    await Navigator.pushNamedAndRemoveUntil(
        MyApp.navigatorKey.currentState!.context,
        '/medicine_item',
        ModalRoute.withName('/home'),
        arguments: med);
  } else {
    DateTime? dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(value));
    await Navigator.pushNamedAndRemoveUntil(
        MyApp.navigatorKey.currentState!.context,
        '/calender',
        ModalRoute.withName('/home'),
        arguments: dateTime);
  }
}

// the main function
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeNotifications();
  tz.initializeTimeZones();

  final prefs = await SharedPreferences.getInstance();
  final langCode = prefs.getString('lang') ?? 'en'; // fallback إلى "en"

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final medicineDao = database.medicineDao;
  final reminderDao = database.reminderDao;
  final reminderCheckDao = database.reminderCheckDao;

  //await addDatabaseDumpData(medicineDao, reminderDao);

  runApp(MyApp(
    initialLocale: Locale(langCode),
    reminderDao: reminderDao,
    medicineDao: medicineDao,
    reminderCheckDao: reminderCheckDao,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
    required this.initialLocale,
    required this.medicineDao,
    required this.reminderDao,
    required this.reminderCheckDao,
  }) : super(key: key);

  final Locale initialLocale;
  final MedicineDao medicineDao;
  final ReminderDao reminderDao;
  final ReminderCheckDao reminderCheckDao;

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  void setLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', locale.languageCode);

    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: _locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: defaultTheme,
        navigatorKey: MyApp.navigatorKey,
        initialRoute: '/',
        routes: {
          '/': (context) => const Splash(),
          '/landing1': (context) => const Landing1(),
          '/landing2': (context) => const Landing2(),
          '/landing3': (context) => const Landing3(),
          '/home': (context) => Home(
                reminderDao: widget.reminderDao,
                reminderCheckDao: widget.reminderCheckDao,
              ),
          '/cabinet': (context) => Cabinet(
                medicineDao: widget.medicineDao,
              ),
          '/medicine_add': (context) => MedicineAddPage(
                medicineDao: widget.medicineDao,
              ),
          '/reminder_add': (context) => ReminderAddPage(
                reminderDao: widget.reminderDao,
                medicineDao: widget.medicineDao,
              ),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/calender') {
            //final passedDay = settings.arguments as DateTime;
            return MaterialPageRoute(
              builder: (context) {
                return Calender(
                  medicineDao: widget.medicineDao,
                  reminderDao: widget.reminderDao,
                  reminderCheckDao: widget.reminderCheckDao,
                  //passedDay: passedDay,
                );
              },
            );
          } else if (settings.name == '/medicine_edit') {
            final med = settings.arguments as Medicine;
            return MaterialPageRoute(
              builder: (context) {
                return MedicineEditPage(
                    medicineDao: widget.medicineDao, med: med);
              },
            );
          } else if (settings.name == '/medicine_item') {
            final med = settings.arguments as Medicine;
            return MaterialPageRoute(
              builder: (context) {
                return MedicineItemPage(
                    medicineDao: widget.medicineDao,
                    reminderDao: widget.reminderDao,
                    med: med);
              },
            );
          } else if (settings.name == '/reminder_add') {
            final med = settings.arguments as Medicine;
            return MaterialPageRoute(
              builder: (context) {
                return ReminderAddPage(
                    medicineDao: widget.medicineDao,
                    reminderDao: widget.reminderDao,
                    savedSelectedMedicine: med);
              },
            );
          }
          //print('Need to implement ${settings.name}');
          return null;
        });
  }
}
