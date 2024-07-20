import 'package:dio/dio.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio = Dio()..interceptors.add(PrettyDioLogger());

  ApiService() {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('https://fakestoreapi.com/products');
      return (response.data as List)
          .map((json) => Product.fromJson(json))
          .toList();
    } on DioException catch (e) {
      _handleDioError(e);
      return [];
    } catch (e) {
      _handleUnexpectedError(e);
      return [];
    }
  }

  void _handleDioError(DioException error) {
    String message;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection Timeout. Please try again later.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send Timeout. Please try again later.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Receive Timeout. Please try again later.';
        break;
      case DioExceptionType.badResponse:
        message = 'Received invalid status code: ${error.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        message = 'Request to API server was cancelled.';
        break;
      case DioExceptionType.unknown:
        message = 'Unexpected error: ${error.message}';
        break;
      case DioExceptionType.badCertificate:
        message = 'Bad Certificate: ${error.message}';
        break;
      case DioExceptionType.connectionError:
        message = 'Connection Error: ${error.message}';
        break;
      default:
        message = 'Unhandled error: ${error.message}';
        break;
    }
    Get.snackbar('Error', message);
  }

  void _handleUnexpectedError(dynamic error) {
    debugPrint('Unexpected error: $error');
    Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
  }
}
