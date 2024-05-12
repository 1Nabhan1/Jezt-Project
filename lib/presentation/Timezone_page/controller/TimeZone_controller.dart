import 'package:get/get.dart';

import '../../../data/apiClient/TimezoneApi/TimeZoneApi.dart';
import '../models/TimeZoneModel.dart';

class TimezoneController extends GetxController {
  var timeZones = [].obs;
  RxList<TimeZoneModel> datas = <TimeZoneModel>[].obs;
  RxString selectedTimezone = ''.obs;
  Map<String, dynamic>? timeZoneData;
  RxBool loading = true.obs;
  RxString error = ''.obs;
  @override
  void onInit() {
    fetchedTimeZones();
    super.onInit();
  }

  void fetchedTimeZones() async {
    try {
      loading.value = true;
      error.value = '';

      List<String> fetchedTimeZones = await fetchTimeZones();
      timeZones.assignAll(fetchedTimeZones);
    } catch (e) {
      // Handle error
      print('Error fetching time zones: $e');
      error.value = 'Failed to fetch time zones';
    } finally {
      loading.value = false;
    }
  }
}
