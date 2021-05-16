import 'package:ziouanexpress/Models/Nearbydriver.dart';

class FireHelper {
  static List<NearbyDriver> nearbyDriverList = [];

  static void removeFromList(String key) {
    int index = nearbyDriverList.indexWhere((element) => element.key == key);

    if (nearbyDriverList.length > 0) {
      nearbyDriverList.removeAt(index);
    }
  }

  static void updateNearbyLocation(NearbyDriver driver) {
    int index =
        nearbyDriverList.indexWhere((element) => element.key == driver.key);

    nearbyDriverList[index].longitude = driver.longitude;
    nearbyDriverList[index].latitude = driver.latitude;
  }

  static bool contains(String key) {
    bool contains = false;
    int index = nearbyDriverList.indexWhere((element) => element.key == key);
    print(index);

    if (index == null) {
      return false;
    } else {
      return true;
    }
  }
}
