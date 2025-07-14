import 'package:ntp/ntp.dart';

Future<DateTime> getCurrentTime() async {
  DateTime now = await NTP.now();
  return now.toLocal();
}
