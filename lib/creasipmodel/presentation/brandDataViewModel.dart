import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hooks_riverpod/hooks_riverpod.dart';
//import 'package:http/http.dart' as http;

final brandDataViewModelProvider = ChangeNotifierProvider((ref) {
  return BrandDataViewModel();
});

class BrandDataViewModel extends ChangeNotifier {
  List<Map<String, dynamic>> brandData = [];
  int _selectedBrandIndex = -1;
  String brandId = '';

//    Future<void> fetchBrands() async {
//   final response = await http
//       .get(Uri.parse('https://fakestoreapi.com/products/category/jewelery'));
//   if (response.statusCode == 200) {
//    // print(response);
//     final jsonList = jsonDecode(response.body);
//     brandData = jsonList.map((json) => json as Map<String, dynamic>).toList();
//   } else {
//     throw Exception('Failed to fetch brands');
//   }
// }

  int getBrandIndex() => _selectedBrandIndex;

  void updateBrandIndex(int index) {  
        _selectedBrandIndex = index;   
        notifyListeners();
  }

  Future<List<dynamic>> fetchBrandsData() async {
    String jsonString =
        await rootBundle.loadString('assets/brands/brands.json');
    List<dynamic> jsonList = json.decode(jsonString);

    brandData = jsonList.map((json) => json as Map<String, dynamic>).toList();
    // Notify listeners that the data has been updated
    notifyListeners();
    return brandData;
  }
}
