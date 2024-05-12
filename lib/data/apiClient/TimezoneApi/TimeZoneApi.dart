import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../presentation/Timezone_page/models/TimeZoneModel.dart';

Future<List<String>> fetchTimeZones() async {
  final response = await http
      .get(Uri.parse('https://timeapi.io/api/TimeZone/AvailableTimeZones'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    List<String> timeZones = List<String>.from(data);
    return timeZones;
  } else {
    throw Exception('Failed to load time zones');
  }
}

// Future<Map<String, dynamic>> fetchTimeZoneData(String timeZone) async {
//   final response = await http.get(
//       Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$timeZone'));
//
//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//   } else {
//     throw Exception('Failed to load time zone data');
//   }
// }
Future<TimeZoneModel> fetchTimeZoneData(String timeZone) async {
  final Uri url = Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$timeZone');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    return TimeZoneModel.fromJson(responseData);
  } else {
    throw Exception('Failed to load time zone data');
  }
}
