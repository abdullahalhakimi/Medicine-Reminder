import 'package:flutter/material.dart';
import 'package:medicine_reminder/components/pageFirstLayout.dart';
import 'package:medicine_reminder/dao/reminder_check_dao.dart';
import 'package:medicine_reminder/dao/reminder_dao.dart';
import 'package:medicine_reminder/entities/reminder.dart';
import 'package:medicine_reminder/extensions/context_extension.dart';
import 'package:medicine_reminder/pages/Home/components/CustomCard.dart';
import 'package:medicine_reminder/pages/calender/components/dateCard.dart';
import 'package:medicine_reminder/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
    required this.reminderDao,
    required this.reminderCheckDao,
  }) : super(key: key);

  final ReminderDao reminderDao;
  final ReminderCheckDao reminderCheckDao;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DateTime _selectedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  //Map timeMap = new Map();
  List timeColumnList = [];

  @override
  Widget build(BuildContext context) {
    final defaultPadding = MediaQuery.of(context).size.width / 20;

    return PageFirstLayout(
      appBarRight: IconButton(
        icon: const Icon(Icons.menu, size: 30),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultPadding),
            ),
            builder: buildBottomSheet,
          );
        },
      ),
      topChild: Padding(
        padding: EdgeInsets.fromLTRB(
            defaultPadding, 0, defaultPadding, defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/cabinet');
              },
              child: CustomCard(
                icon: Image.asset(
                  'assets/cabinet.png',
                  width: 80,
                ),
                title: 'My Medicines',
              ),
            ),
            GestureDetector(
              onTap: () {
                goToCalender(context);
              },
              child: CustomCard(
                icon: Image.asset(
                  'assets/calender.png',
                  width: 80,
                ),
                title: 'My Reminders',
              ),
            ),
          ],
        ),
      ),
      containerChild: Padding(
        padding: EdgeInsets.fromLTRB(defaultPadding, defaultPadding, 0, 0),
        child: ListView(
          children: [
            DateCard(_selectedDay),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                goToCalender(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: StreamBuilder<List<Reminder>>(
                          stream: widget.reminderDao.findReminderForDayAsStream(
                              _selectedDay.toString(), _selectedDay.weekday),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text('error');
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 50),
                                  child: Text(
                                    'No Reminders Today',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                              );
                            }

                            final reminders = snapshot.requireData;

                            if (reminders.isEmpty) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 50),
                                  child: Text(
                                    'No Reminders Today',
                                    style: TextStyle(color: Colors.black54),
                                  ),
                                ),
                              );
                            }

                            // reminders.sort((a, b) =>
                            //     DateTime(1, 1, 1999, a.dateTime.hour, a.dateTime.minute).compareTo(
                            //         DateTime(1, 1, 1999, b.dateTime.hour, b.dateTime.minute)));
                            //
                            // var newMap = groupBy(reminders, (Reminder reminderItem) =>
                            // '${reminderItem.dateTime.hour < 10? '0': ''}${reminderItem.dateTime.hour}:'
                            // '${reminderItem.dateTime.minute < 10? '0': ''}${reminderItem.dateTime.minute}');
                            //
                            // return Column(
                            //   children: newMap.entries.map((timeGroup) {
                            //     return getTimeGroup(timeGroup);
                            //   }).toList(),
                            // );

                            reminders.sort((a, b) {
                              int cmp = DateTime(1, 1, 1999, a.dateTime.hour,
                                      a.dateTime.minute)
                                  .compareTo(DateTime(1, 1, 1999,
                                      b.dateTime.hour, b.dateTime.minute));
                              if (cmp != 0) return cmp;
                              return a.medicineName.compareTo(b.medicineName);
                            });

                            timeColumnList.clear();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  reminders.asMap().entries.map((reminder) {
                                return getReminderRow(reminder.value);
                              }).toList(),
                            );
                          })
                      // Column(
                      )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goToCalender(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/calender',
      ModalRoute.withName('/home'),
      arguments: _selectedDay,
    );
  }

  Row getReminderRow(Reminder reminderItem) {
    var timeLabel =
        '${reminderItem.dateTime.hour < 10 ? '0' : ''}${reminderItem.dateTime.hour}:'
        '${reminderItem.dateTime.minute < 10 ? '0' : ''}${reminderItem.dateTime.minute}';

    //timeMap.containsKey(time)? timeMap[time]+=1 : timeMap[time] =1;
    //var timeLabel = '';
    timeColumnList.isEmpty || timeColumnList[0] != timeLabel
        ? timeColumnList.insert(0, timeLabel)
        : timeLabel = '';
    //timeLabel = time;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 75,
              ),
              child: Text(
                timeLabel,
                style: const TextStyle(
                    fontSize: 18,
                    color: MyColors.lightBlue,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(width: 3.0, color: MyColors.lightGreen),
            ),
            color: Colors.white,
          ),
          child: Text(
            '   ${reminderItem.medicineName}',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

Widget buildBottomSheet(BuildContext context) {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            label: Text(context.localizations!.linkedIn),
            icon: Image.asset('assets/linkedin.png'),
            onPressed: () {
              _launchURL('https://www.linkedin.com/in/abdullah-al-hakimi-465025221');
            },
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            label: Text(context.localizations!.playStore),
            icon: Image.asset('assets/play-store.png'),
            onPressed: () {
              _launchURL('https://play.google.com/store/apps/details?id=com.medicine_reminder.medicine_reminder');
            },
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            label: Text(
              Localizations.localeOf(context).languageCode == 'en'
                  ? 'Change Language To Arabic'
                  : 'تغيير اللغة الى الانجليزية',
            ),
            icon: const Icon(Icons.language,color: Colors.blue,),
            onPressed: () {
              final currentLocale =
                  Localizations.localeOf(context).languageCode;

              final newLocale = currentLocale == 'en'
                  ? const Locale('ar')
                  : const Locale('en');

              MyApp.of(context)?.setLocale(newLocale);
            },
          ),
        ],
      ),
    ),
  );
}

_launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}