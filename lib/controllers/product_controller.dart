import 'package:e_commerce_app/models/products.dart';
import 'package:e_commerce_app/services/api_services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var filteredProducts = <Product>[].obs;
  var isLoading = true.obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    // Fetch products from API
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      List<Product> productList = await _apiService.getProducts();
      products.assignAll(productList);
      filteredProducts.assignAll(products);
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      var lowercaseQuery = query.toLowerCase();
      var filteredList = products
          .where(
              (product) => product.title.toLowerCase().contains(lowercaseQuery))
          .toList();
      filteredProducts.assignAll(filteredList);
    }
  }
}
