import 'package:appcreasip/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../creasipmodel/presentation/brandDataViewModel.dart';
import '../../util/consts/screen_routes.dart';

class BrandListScreen extends ConsumerStatefulWidget {
  const BrandListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BrandListScreenState();
}

class _BrandListScreenState extends ConsumerState<BrandListScreen> {
  late BrandDataViewModel _brandDataViewModel;

  @override
  Widget build(BuildContext context) {
    _brandDataViewModel = ref.watch(brandDataViewModelProvider.notifier);

    // Get the selected category from route arguments
    final category = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<List<dynamic>>(
        future: _brandDataViewModel.fetchBrandsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading indicator while data is being fetched
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<dynamic> brandData = snapshot.data!;

            // Filter brandData based on the selected category
            if (category != null && category.isNotEmpty) {
              brandData = brandData
                  .where((brand) => brand['category'] == category)
                  .toList();
            }

            return SingleChildScrollView(
              child: _buildBrandList(brandData, context),
            );
          }
        },
      ),
    );
  }

  Widget _buildBrandList(List<dynamic> brandData, BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: brandData.length,
      itemBuilder: (BuildContext context, int index) {
       final String brand = brandData[index]['brand'];
       final String logo = brandData[index]['logo'];
        
        return GestureDetector(
          onTap: () {
            _brandDataViewModel.updateBrandIndex(index);
            Navigator.of(context).pushNamed(productListScreenRoute);
          },
          child: Padding(
  padding: const EdgeInsets.all(10.0),
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey[300]!,
        width: 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(logo),
              fit: BoxFit.cover,
            ),
          ),
        ),
       // SizedBox(height: 10.0),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(logo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    brand,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              Text('112/200 shortlisted'),
            ],
          ),
        ),
      //SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Container(
  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 211, 113, 21), // Set the desired background color
    borderRadius: BorderRadius.circular(5.0), // Set the desired border radius
  ),
  child: Text(
    'Barter',
    style: TextStyle(
      color: Colors.white, // Set the desired text color
      fontWeight: FontWeight.w300,
    ),
  ),
),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1K-200M'),
              Text('15 days ago')
            ],
          )
        ],),
      )
      ],
    ),
  ),
),
  );
      },
    );
  }
}
