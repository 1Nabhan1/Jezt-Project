import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jzt_mt_project/presentation/Timezone_page/controller/TimeZone_controller.dart';

import 'TimeZoneDetails.dart';

class Timezonelist extends StatelessWidget {
  Timezonelist({Key? key});
  final TimezoneController timezoneController = Get.put(TimezoneController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new)),
        title: Text(
          'Select a Timezone',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () {
                if (timezoneController.loading.value) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .3,
                        ),
                        CircularProgressIndicator()
                      ]),
                    ],
                  );
                } else if (timezoneController.error.value.isNotEmpty) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .3,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              ' ${timezoneController.error.value}',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: Colors.greenAccent,
                            ),
                            onPressed: () async {
                              timezoneController.fetchedTimeZones();
                            },
                            child: Text(
                              'Retry',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: timezoneController.timeZones.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(TimeZoneDetailPage(
                            timeZone: timezoneController.timeZones[index],
                          ));
                        },
                        child: ListTile(
                          title: Text(
                            timezoneController.timeZones[index],
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
