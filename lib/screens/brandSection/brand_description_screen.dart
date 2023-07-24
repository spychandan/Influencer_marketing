import 'package:appcreasip/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../creasipmodel/presentation/brandDataViewModel.dart';

class BrandDescription extends ConsumerStatefulWidget {
  const BrandDescription({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BrandDescriptionState();
}

class _BrandDescriptionState extends ConsumerState<BrandDescription> {
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
            //print(selectedBrandIndex);
            final selectedBrand = brandData[
                selectedBrandIndex]; // Assuming you have the index of the selected brand

            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(selectedBrand['logo']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
                        SizedBox(width: 8.0),
                      Text(
                        selectedBrand['brand'],
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    selectedBrand['description'],
                    style: TextStyle(fontSize: 14.0),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
