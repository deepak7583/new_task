import 'package:e_commerce_app/controllers/cart_controllers.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.toNamed('/cart');
                },
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Obx(() => cartController.cartItems.isEmpty
                    ? const SizedBox()
                    : CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 10,
                        child: Text(
                          cartController.totalItems.value.toString(),
                          style: const TextStyle(fontSize: 12),
                        ),
                      )),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(
                product.image,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Obx(() {
                int quantity = cartController.getQuantity(product.id);

                return Column(
                  children: [
                    quantity > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (quantity > 0) {
                                    cartController.decreaseQuantity(product.id);
                                  }
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              Text(
                                quantity.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (quantity == 0) {
                                    cartController.addToCart(
                                        product.copyWith(quantity: 1));
                                  } else {
                                    cartController.increaseQuantity(product.id);
                                  }
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          )
                        : Container(),
                    const SizedBox(height: 16),
                    quantity < 1
                        ? ElevatedButton(
                            onPressed: () {
                              if (quantity == 0) {
                                cartController.addToCart(product);
                              }
                            },
                            child: const Text('Add to Cart'),
                          )
                        : Container(),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
