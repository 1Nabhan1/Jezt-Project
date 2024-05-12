// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class TimeZoneDetailPage extends StatefulWidget {
//   final String timeZone;
//
//   TimeZoneDetailPage({required this.timeZone});
//
//   @override
//   _TimeZoneDetailPageState createState() => _TimeZoneDetailPageState();
// }
//
// class _TimeZoneDetailPageState extends State<TimeZoneDetailPage> {
//   Map<String, dynamic>? timeZoneData;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }
//
//   void fetchData() async {
//     try {
//       final data = await fetchTimeZoneData(widget.timeZone);
//       setState(() {
//         timeZoneData = data;
//       });
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Time Zone Details'),
//       ),
//       body: Center(
//         child: timeZoneData != null
//             ? Text('Time zone data for ${widget.timeZone}: ${timeZoneData.toString()}')
//             : CircularProgressIndicator(),
//       ),
//     );
//   }
// }
//
// Future<Map<String, dynamic>> fetchTimeZoneData(String timeZone) async {
//   final response = await http.get(Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$timeZone'));
//
//   if (response.statusCode == 200) {
//     // If the server returns a 200 OK response, parse the JSON
//     return jsonDecode(response.body);
//   } else {
//     // If the server returns an error response, throw an exception.
//     throw Exception('Failed to load time zone data');
//   }
// }
