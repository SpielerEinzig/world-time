import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  late String time;
  String url;
  String flag;
  String location;
  late bool isDayTime;

  WorldTime({
    required this.url,
    required this.location,
    required this.flag,
  });

  Future<void> getData() async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://worldtimeapi.org/api/timezone/$url'),
      );
      Map data = jsonDecode(response.body);

      String dateTime = data["datetime"];
      String offset = data["utc_offset"].substring(1, 3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      if (now.hour > 6 && now.hour < 20) {
        isDayTime = true;
      } else {
        isDayTime = false;
      }

      time = DateFormat.jm().format(now);
    } catch (e) {
      print("caught error $e");
      time = "could not fetch time data";
    }
  }
}
