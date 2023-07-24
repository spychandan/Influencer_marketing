import 'package:appcreasip/screens/brandSection/applicant_form.dart';
import 'package:appcreasip/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../creasipmodel/presentation/brandDataViewModel.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  late BrandDataViewModel _brandDataViewModel;
  @override
  Widget build(BuildContext context) {
    _brandDataViewModel = ref.watch(brandDataViewModelProvider.notifier);
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<List<dynamic>>(
        future: _brandDataViewModel.fetchBrandsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading indicator while data is being fetched
          } else if (snapshot.hasError) {
            return SnackBar(content: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> brandData = snapshot.data!;
            int selectedBrandIndex = _brandDataViewModel.getBrandIndex();
            final selectedBrand = brandData[selectedBrandIndex];
            List<Map<String, dynamic>> products =
                List<Map<String, dynamic>>.from(selectedBrand["products"]);

            // Building the table rows
            List<DataRow> tableRows = products.map((product) {
              String productName = product["productName"];

              return DataRow(
                cells: [
                  DataCell(Text("${products.indexOf(product) + 1}")),
                  DataCell(Text(productName)),
                  DataCell(ElevatedButton(
                    onPressed: () {
                       Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ApplicantForm(
          productId: product["productId"],
          productName: product["productName"],
        ),
      ),
    );
                      // Apply button logic
                    },
                    child: Text("Apply"),
                  )),
                ],
              );
            }).toList();

            return SingleChildScrollView(
              child: DataTable(
                columns: [
                  DataColumn(label: Text("S. No")),
                  DataColumn(label: Text("Product Name")),
                  DataColumn(label: Text("Apply")),
                ],
                rows: tableRows,
              ),
            );
          }
        },
      ),
    );
  }
}
