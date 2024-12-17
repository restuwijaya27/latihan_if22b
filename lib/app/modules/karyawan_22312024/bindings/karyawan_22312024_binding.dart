import 'package:get/get.dart';

import '../controllers/karyawan_22312024_controller.dart';

class karyawan_22312024Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<karyawan_22312024Controller>(
      () => karyawan_22312024Controller(),
    );
  }
}