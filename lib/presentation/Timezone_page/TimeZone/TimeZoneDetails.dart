import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/apiClient/TimezoneApi/TimeZoneApi.dart';
import '../models/TimeZoneModel.dart';

class TimeZoneDetailPage extends StatefulWidget {
  final String timeZone;

  TimeZoneDetailPage({required this.timeZone});

  @override
  _TimeZoneDetailPageState createState() => _TimeZoneDetailPageState();
}

class _TimeZoneDetailPageState extends State<TimeZoneDetailPage> {
  TimeZoneModel? timeZoneData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      final data = await fetchTimeZoneData(widget.timeZone);
      setState(() {
        timeZoneData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        leading: GestureDetector(
          onTap: Get.back,
          child: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Time Zone Details'),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : timeZoneData != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Time zone: ${timeZoneData!.timeZone}',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Date: ${timeZoneData!.date}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Week: ${timeZoneData!.dayOfWeek}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Time: ${timeZoneData!.time}',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                      // Add more attributes as needed
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Failed to fetch data'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                          });
                          fetchData();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
      ),
    );
  }
}
