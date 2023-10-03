import 'package:flutter/material.dart';
import 'package:sundari/common/widgets/bottom_bar.dart';
import 'package:sundari/features/address/screens/address_screen.dart';
import 'package:sundari/features/admin/screens/add_product_screen.dart';
import 'package:sundari/features/admin/screens/admin_screen.dart';
import 'package:sundari/features/auth/screens/auth_screen.dart';
import 'package:sundari/features/home/screens/category_deals_screen.dart';
import 'package:sundari/features/home/screens/home_screen.dart';
import 'package:sundari/features/order_details/screens/order_details_screen.dart';
import 'package:sundari/features/product_details/screens/product_details_screen.dart';
import 'package:sundari/features/search/screens/search_screen.dart';
import 'package:sundari/models/order.dart';
import 'package:sundari/models/product.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AuthScreen());
    case AdminScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AdminScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case BottomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BottomBar());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AddProductScreen());
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(
                category: category,
              ));
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
            product: product,
          ));
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(
            totalAmount: totalAmount,
          ));
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(
            order: order,
          ));
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Screen does not exist!!'),
                ),
              ));
  }
}
