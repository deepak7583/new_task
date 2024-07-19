import 'package:e_commerce_app/controllers/auth_controllers.dart';
import 'package:e_commerce_app/controllers/cart_controllers.dart';
import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:get/get.dart';


class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<CartController>(() => CartController());
  }
}
