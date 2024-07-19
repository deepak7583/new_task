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
    final ValueNotifier<int> quantity = ValueNotifier<int>(1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Quantity:'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity.value > 1) {
                            quantity.value--;
                          }
                        },
                      ),
                      ValueListenableBuilder<int>(
                        valueListenable: quantity,
                        builder: (context, value, child) => Text(
                          value.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartController.addToCart(
                            product.copyWith(quantity: quantity.value),
                          );
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      cartController.addToCart(
                        product.copyWith(quantity: quantity.value),
                      );
                      Get.snackbar(
                        'Added to Cart',
                        '${product.title} added to your cart.',
                        duration: const Duration(seconds: 2),
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
