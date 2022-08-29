import 'package:get/get.dart';
import 'package:controlecarnet/controller/carnet_controller.dart';


class AppBinding extends Bindings {

  @override
    void dependencies() {
      Get.put(CarnetController(), permanent: true);

    }
}
