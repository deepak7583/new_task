import 'package:dio/dio.dart';
import 'package:e_commerce_app/models/products.dart';
import 'package:flutter/cupertino.dart';
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
      debugPrint('Unexpected error: $e');
      return [];
    }
  }

  void _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        debugPrint('Connection Timeout Exception');
        break;
      case DioExceptionType.sendTimeout:
        debugPrint('Send Timeout Exception');
        break;
      case DioExceptionType.receiveTimeout:
        debugPrint('Receive Timeout Exception');
        break;
      case DioExceptionType.badResponse:
        debugPrint(
            'Received invalid status code: ${error.response?.statusCode}');
        debugPrint('Error data: ${error.response?.data}');
        break;
      case DioExceptionType.cancel:
        debugPrint('Request to API server was cancelled');
        break;
      case DioExceptionType.unknown:
        debugPrint('Unexpected error: ${error.message}');
        break;
      case DioExceptionType.badCertificate:
        debugPrint('Bad Certificate: ${error.message}');
        break;
      case DioExceptionType.connectionError:
        debugPrint('Connection Error: ${error.message}');
        break;
      default:
        debugPrint('Unhandled DioError: ${error.message}');
        break;
    }
  }
}
