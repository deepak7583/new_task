import 'package:e_commerce_app/controllers/cart_controllers.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(child: Text('Your cart is empty'));
        } else {
          return ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) {
              Product product = cartController.cartItems[index];
              return ListTile(
                leading: Image.network(product.image),
                title: Text(product.title),
                subtitle: Text('\$${product.price}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    cartController.removeFromCart(product.id);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
