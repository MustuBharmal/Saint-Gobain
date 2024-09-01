import 'package:get/get.dart';

import '../presentation/auth/auth_screen.dart';
import '../presentation/auth/splash_screen.dart';
import '../presentation/home/binding/homepage_bindings.dart';
import '../presentation/home/home_page.dart';
import '../presentation/retail_outlet/add_retail_outlet_screen.dart';
import '../presentation/retail_outlet/binding/retail_outlet_bindings.dart';
import '../presentation/retail_outlet/list_of_retail_outlet_screen.dart';
import '../presentation/site/add_site_screen.dart';
import '../presentation/site/binding/site_bindings.dart';
import '../presentation/site/list_of_sites_screen.dart';

class AppRoutes {
  static List<GetPage> pages = [
    GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
    GetPage(name: LoginView.routeName, page: () => LoginView()),
    GetPage(
        name: HomePage.routeName,
        page: () => const HomePage(),
        binding: HomePageBinding()),
    GetPage(
        name: ListOfSitesScreen.routeName,
        page: () => const ListOfSitesScreen(),
        binding: SiteBinding()),
    GetPage(
        name: AddSiteScreen.routeName,
        page: () => AddSiteScreen(),
        binding: SiteBinding()),
    GetPage(
        name: ListOfRetailOutletScreen.routeName,
        page: () => const ListOfRetailOutletScreen(),
        binding: RetailOutletBinding()),
    GetPage(
        name: AddRetailOutletScreen.routeName,
        page: () => AddRetailOutletScreen(),
        binding: RetailOutletBinding()),
  ];
}
