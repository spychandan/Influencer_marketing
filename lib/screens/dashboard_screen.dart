import 'package:appcreasip/creasipmodel/presentation/brandDataViewModel.dart';
import 'package:appcreasip/util/consts/screen_routes.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late BrandDataViewModel _brandDataViewModel;

  @override
  Widget build(BuildContext context) {
    _brandDataViewModel = ref.watch(brandDataViewModelProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Hi,', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.account_balance_wallet),
            onPressed: () {
              // TODO: Handle wallet icon press
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // TODO: Handle drawer item tap
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // TODO: Handle drawer item tap
              },
            ),
            ListTile(
              title: Text('Item 3'),
              onTap: () {
                // TODO: Handle drawer item tap
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _brandDataViewModel.fetchBrandsData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator while data is being fetched
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<dynamic> brandData = snapshot.data!;
            List<dynamic> uniqueCategories =
                brandData.map((brand) => brand['category']).toSet().toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Top Brands',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 4,
                            children: brandData.asMap().entries.map((entry) {
                              final int index = entry.key;
                              final dynamic brand = entry.value;
                              return _buildBrandItem(brand, index, context);
                            }).toList(),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(brandListScreenRoute);
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'more >',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 55, 100),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Top Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 4,
                      children: uniqueCategories.asMap().entries.map((entry) {
                         final int index = entry.key;
                        final dynamic category = entry.value;
                        final dynamic brand = brandData.firstWhere(
                            (brand) => brand['category'] == category);
                        return _buildCategoryItem(brand,index, context);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCategoryItem(
      dynamic brandData,int index, BuildContext context) {
    final String category = brandData['category'];
    final String categoryLogo = brandData['categoryLogo'];
    return InkWell(
      onTap: () {
        _brandDataViewModel.updateBrandIndex(index);
        Navigator.of(context)
            .pushNamed(brandListScreenRoute, arguments: category);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 2),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(categoryLogo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                category,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandItem(dynamic brandData, int index, BuildContext context) {
    final String brand = brandData['brand'];
    final String logo = brandData['logo'];

    return InkWell(
      onTap: () {
        //  print(brandData);
        _brandDataViewModel.updateBrandIndex(index);
        //print()
        Navigator.of(context).pushNamed(brandDescriptionScreenRoute);
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 2),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(logo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8.0), 
              Text(
                brand,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
