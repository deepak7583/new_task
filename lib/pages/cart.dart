import 'package:e_commerce_app/controllers/auth_controllers.dart';
import 'package:e_commerce_app/controllers/cart_controllers.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.find();
  final AuthController authController = Get.find();

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(child: Text('Your cart is empty'));
        } else {
          return ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) {
              Product product = cartController.cartItems[index];
              return ListTile(
                leading: Image.network(product.image),
                title: Text(product.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\$${product.price.toStringAsFixed(2)}'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            cartController.decreaseQuantity(product.id);
                          },
                        ),
                        Text(
                          product.quantity.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            cartController.increaseQuantity(product.id);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_shopping_cart),
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
