import 'package:e_commerce_app/models/products.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;
  var totalItems = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  void loadCart() {
    final box = GetStorage();
    if (box.hasData('cartItems')) {
      var storedItems = box.read<List>('cartItems')!;
      cartItems.assignAll(
          storedItems.map((item) => Product.fromJson(Map<String, dynamic>.from(item))).toList());
      updateTotalItems();
    }
  }

  void addToCart(Product product) {
    if (isInCart(product.id)) {
      increaseQuantity(product.id);
    } else {
      cartItems.add(product.copyWith(quantity: 1));
    }
    saveCart();
    updateTotalItems();
  }

  void increaseQuantity(int productId) {
    var index = cartItems.indexWhere((item) => item.id == productId);
    cartItems[index] =
        cartItems[index].copyWith(quantity: cartItems[index].quantity + 1);
    saveCart();
    updateTotalItems();
  }

  void decreaseQuantity(int productId) {
    var index = cartItems.indexWhere((item) => item.id == productId);
    if (cartItems[index].quantity > 1) {
      cartItems[index] =
          cartItems[index].copyWith(quantity: cartItems[index].quantity - 1);
      saveCart();
      updateTotalItems();
    } else {
      removeFromCart(productId); // Call removeFromCart when quantity is 1
    }
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.id == productId);
    saveCart();
    updateTotalItems();
  }

  bool isInCart(int productId) {
    return cartItems.any((item) => item.id == productId);
  }

  int getQuantity(int productId) {
    var index = cartItems.indexWhere((item) => item.id == productId);
    return index != -1 ? cartItems[index].quantity : 0;
  }

  void setQuantity(int productId, int quantity) {
    var index = cartItems.indexWhere((item) => item.id == productId);
    if (index != -1) {
      cartItems[index] = cartItems[index].copyWith(quantity: quantity);
      saveCart();
      updateTotalItems();
    }
  }

  void saveCart() {
    final box = GetStorage();
    box.write('cartItems', cartItems.map((item) => item.toJson()).toList());
  }

  void updateTotalItems() {
    totalItems.value = cartItems.fold(0, (sum, item) => sum + item.quantity);
  }
}
