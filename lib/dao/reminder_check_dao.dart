import 'package:floor/floor.dart';
import 'package:medicine_reminder/entities/reminderCheck.dart';
import 'package:medicine_reminder/util/converters/DateTimeConverter.dart';

@dao
abstract class ReminderCheckDao {

  @TypeConverters([DateTimeConverter])
  @Query('SELECT * FROM reminders_check WHERE scheduledDateTime =:datetime AND reminder_id =:reminderId')
  Future<ReminderCheck?> findReminderByScheduledDate(DateTime datetime, int reminderId);

  @insert
  Future<void> insertReminderCheck(ReminderCheck check);

  @delete
  Future<void> deleteReminderCheck(ReminderCheck check);

}