import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder/dao/medicine_dao.dart';
import 'package:medicine_reminder/dao/reminder_dao.dart';
import 'package:medicine_reminder/entities/medicine.dart';
import 'package:medicine_reminder/pages/medicineItemPage/components/CustomCard.dart';
import 'package:medicine_reminder/theme.dart';
import 'package:medicine_reminder/util/notificationUtil.dart';

class MedicineItemPage extends StatefulWidget {
  const MedicineItemPage({Key? key,
    required this.medicineDao,
    required this.reminderDao,
    required this.med
  }) : super(key: key);


  final MedicineDao medicineDao;
  final ReminderDao reminderDao;
  final Medicine med;

  @override
  _MedicineItemPageState createState() => _MedicineItemPageState();
}

class _MedicineItemPageState extends State<MedicineItemPage> {

  Medicine medicineItem = Medicine(name: '');
  //medicineItem.supplyCurrent


  @override
  void initState() {
    super.initState();
    setState(() {
      medicineItem = widget.med;
    });
  }


  @override
  Widget build(BuildContext context) {
    // convert double to string
    String intSupplyCurrent = NumberFormat("#.##", "en_US").format(medicineItem.supplyCurrent);
    String intSupplyMin = NumberFormat("#.##", "en_US").format(medicineItem.supplyMin);
    String intDose = NumberFormat("#.##", "en_US").format(medicineItem.dose);
    String intCapSize = NumberFormat("#.##", "en_US").format(medicineItem.capSize);

    final defaultPadding = MediaQuery. of(context). size. width / 20;
    var image = 'assets/medicineBottle.png';
    if(medicineItem.pillShape == 'assets/capsule.png'){
      image = 'assets/capsuleGroup.png';
    }else if(medicineItem.pillShape == 'assets/roundedpill.png'){
      image = 'assets/roundGroup.png';
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: MyColors.darkBlue, //change your color here
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu,color: MyColors.darkBlue),
              onPressed: (){
                showModalBottomSheet<void>(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultPadding),
                  ),
                  builder: buildBottomSheet,
                );
              },
            ),
          ],
        ),   //showFAB: false,

      body: ListView(
        children: [
          Center(
            child:Stack(
              children: [
                Container(height: 225, width: 150, color:medicineItem.pillColor,),
                Image.asset(image, height: 225, width: 150,)
              ],
            ),
          ), const SizedBox(height: 32,),
          Padding(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(medicineItem.name, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8,),
                      medicineItem.desc.isNotEmpty ? Column(
                        children: [
                          Text(
                            medicineItem.desc,
                            softWrap: true,
                            //style: TextStyle(color: Colors.black54),
                          ),
                          const SizedBox(height: 16,),
                        ],
                      ) : const SizedBox(),
                      Wrap(
                        runSpacing: 2,
                        spacing: 5,
                        children: medicineItem.tags.map((tag) =>
                            Chip(
                              label: Text(tag, ),
                              backgroundColor: MyColors.lightBlue.withOpacity(0.5),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            )
                        ).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16,),
                Row(
                  children: [
                    CustomCard(
                      title: 'Available',
                      data: '$intSupplyCurrent pills',
                      icon: const Icon(
                        Icons.assignment_turned_in,
                        color: MyColors.lightBlue,
                      ),
                      color: MyColors.lightBlue,
                    ),
                    CustomCard(
                      title: 'Alert on',
                      data: '$intSupplyMin pills',
                      icon: const Icon(
                        Icons.assignment_late,
                        color: Color(0xffda4625),
                      ),
                      color: const Color(0xffda4625),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomCard(
                      title: 'Dose',
                      data: '$intDose pills/dose',
                      icon: const Icon(
                        Icons.timelapse,
                        color: MyColors.lightRed,
                      ),
                      color: MyColors.lightRed,
                    ),
                    CustomCard(
                      title: 'Strength',
                      data: '$intCapSize mg',
                      icon: const Icon(
                        Icons.hourglass_bottom,
                        color: Colors.purple,
                      ),
                      color: Colors.purple,
                    ),
                  ],
                ),
                const SizedBox(height: 32,),
              ],
            ),
          ),

        ],
      )
    );
  }

  Widget buildBottomSheet(BuildContext context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery. of(context). size. width / 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                label: const Text('Take Dose'),
                icon: const Icon(Icons.timelapse,color: MyColors.lightGreen),
                onPressed: () {
                  takeDose(context);
                },
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                label: const Text('Add Reminder'),
                icon: const Icon(Icons.notification_add,color: MyColors.lightGreen),
                onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/reminder_add', arguments: medicineItem);
                },
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                label: const Text('Edit Medicine'),
                icon: const Icon(Icons.edit,color: MyColors.lightGreen),
                onPressed: () {
                  Navigator.pushNamed(context, '/medicine_edit', arguments: medicineItem);
                },
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, textStyle: Theme.of(context).textTheme.bodyLarge,
                ),
                label: const Text('Delete Medicine'),
                icon: const Icon(Icons.delete,color: MyColors.lightGreen),
                onPressed: () {
                  showDeleteDialog(context);

                },
              ),
            ],
          ),
        ),
      );
    }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child:
            Text('${medicineItem.name} will be permanently deleted.', style: const TextStyle(fontSize: 14),)
          ),
          actions: [
            TextButton(
              child: const Text("Delete", style: TextStyle(fontSize: 14),),
              onPressed: () {
                onDeleteMedicine(context);
              },

            ),
            TextButton(
              child: const Text("Cancel", style: TextStyle(fontSize: 14),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void onDeleteMedicine(BuildContext context) {
    widget.reminderDao.findReminderByMedicineId(medicineItem.id ?? 0).then((reminders) {
      for (var reminder in reminders) {
        cancelNotification(reminder.id ?? 0);
        widget.reminderDao.deleteReminder(reminder);
      }
      widget.medicineDao.deleteMedicine(medicineItem).then((value) => null);
      Navigator.popUntil(context, ModalRoute.withName('/cabinet'));
    });

  }

  void takeDose(BuildContext context) {
    if(medicineItem.supplyCurrent >= medicineItem.dose) {
      setState(() {
        medicineItem = medicineItem.copyWith(
            supplyCurrent: medicineItem
                .supplyCurrent - medicineItem.dose);
      });
      widget.medicineDao.updateMedicine(medicineItem).then((value) {
          Navigator.pop(context);
      });
    }
    else{
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${medicineItem.name} supply is empty' )),
      );
    }

    if(medicineItem.supplyCurrent == 0){
      singleNotificationCallback( 1, '${medicineItem.name} Refill', 'current supply is empty.',
          DateTime.now(), 'medicine ${medicineItem.id}', sound: 'happy_tone_short').then((value) => null);
    }
    else if(medicineItem.supplyCurrent <= medicineItem.supplyMin){
      singleNotificationCallback( 1, '${medicineItem.name} Refill', 'current supply  is running out.',
          DateTime.now(), 'medicine ${medicineItem.id}', sound: 'happy_tone_short').then((value) => null);
    }
  }
}
