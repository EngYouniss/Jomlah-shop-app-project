import 'dart:io';

import 'package:bazar_flow/core/constants/api_routes.dart';
import 'package:bazar_flow/core/models/product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductVM {
  List<Product> ListProduct = [];

  Future<List<Product>> loadProducts() async {
    try {
      Dio productElement = Dio();

      Response<Map<String, dynamic>> feedback =
      await productElement.get(APIRoutes.productPage);


      List<dynamic> data = feedback.data!["products"];

      ListProduct = data.map((element) => Product.fromJSON(element)).toList();

      return ListProduct;
    } catch (e) {
      print("Error loading products: $e");
      return [];
    }
  }


}
