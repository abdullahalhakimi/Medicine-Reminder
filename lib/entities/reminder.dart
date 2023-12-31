import 'package:floor/floor.dart';
import 'package:medicine_reminder/entities/medicine.dart';
import 'package:medicine_reminder/util/converters/DateTimeConverter.dart';


@Entity(
  tableName: 'reminders',
  foreignKeys: [
    ForeignKey(
      childColumns: ['medicine_id'],
      parentColumns: ['id'],
      entity: Medicine,
      onDelete: ForeignKeyAction.cascade
    )
  ],
)
class Reminder {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'medicine_id')
  final int medicineId;
  final String medicineName;
  //to query reminders with date (for once reminders)
  final String date;
  // to query reminders with weekday (for repeated reminders)
  final int day;
  // mostly to get the time actually
  final DateTime dateTime;  
  final String label;
  // is it repeated or a once?
  final bool repeated;

  @TypeConverters([DateTimeConverter])
  Reminder(
      {
        this.id,
        required this.medicineId,
        this.medicineName : '',
        String? date,
        int? day,
        required this.dateTime,
        this.label: '',
        this.repeated: false

      }) : this.date = date ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toString(),
           this.day = day ?? DateTime.now().day ;
}