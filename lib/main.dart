import 'package:appcreasip/screens/brandSection/applicant_form.dart';
import 'package:appcreasip/screens/brandSection/brand_description_screen.dart';
import 'package:appcreasip/screens/brandSection/brand_list_screen.dart';
import 'package:appcreasip/screens/brandSection/products_list_screen.dart';
import 'package:appcreasip/screens/dashboard_screen.dart';
import 'package:appcreasip/screens/home_screen.dart';
import 'package:appcreasip/screens/signup_screen.dart';
import 'package:appcreasip/screens/switch_selection.dart';
import 'package:appcreasip/util/consts/screen_routes.dart';
import 'package:appcreasip/widgets/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
      routes: {
        switchSelectionRoute: (context) => SwitchSelection(),
        signUpScreenRoute: (context) => SignUpScreen(),
        dashboardScreenRoute: (context) => DashboardScreen(),
        bottomNavigationRoute: (context) => BottomNavigationWidget(),
        brandDescriptionScreenRoute:(context) => BrandDescription(),
        brandListScreenRoute:(context) => BrandListScreen(),
        productListScreenRoute:(context) => ProductListScreen(),
        applicantFormRoute:(context) => ApplicantForm(productId: '', productName: '',),
      },
    );
  }
}
