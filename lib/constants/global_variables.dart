import 'package:flutter/material.dart';

String uri = "http://192.168.26.224:3000";

class GlobalVariables {
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromRGBO(248, 54, 209, 0.295),
      Color.fromRGBO(255, 54, 215, 0.169),
    ],
    stops: [0.5, 1.0],
  );

  static const authScreenGradient = LinearGradient(
    colors: [
      Color.fromRGBO(250, 201, 239, 1),
      Color.fromRGBO(252, 223, 246, 1),
      Color.fromRGBO(250, 250, 250, 1),
    ],
  );

  static const secondaryColor = Color.fromRGBO(197, 1, 223, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = const Color.fromARGB(255, 107, 0, 121);
  static const unselectedNavBarColor = Colors.black87;
  static const goldenColor = Color.fromRGBO(255, 153, 0, 1);
  static const mainColor = Color.fromARGB(255, 105, 0, 119);

  static const String pexelsKey =
      'ddyrk0IqQkYVvl4xw9jZc2GfMvWlAnN0S0shlBKn33IIo6gWOXDhsQCf';

// STATIC IMAGES
  static const List<String> carouselImages = [
    'https://www.shutterstock.com/shutterstock/photos/642327187/display_1500/stock-vector-oatmeal-ad-with-milk-splashing-and-mixed-berries-d-illustration-642327187.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1805987068/display_1500/stock-vector-delicious-fried-chicken-in-d-illustration-with-fire-and-chili-concept-of-spicy-flavor-1805987068.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1023594961/display_1500/stock-vector-blueberry-yogurt-ads-delicious-yogurt-commercial-with-milk-and-fruit-jam-splashing-together-in-d-1023594961.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1120833698/display_1500/stock-vector-delicious-fluffy-pancake-in-frying-pan-fresh-fruit-and-honey-toppings-in-d-illustration-food-ad-1120833698.jpg',
    'https://www.shutterstock.com/shutterstock/photos/2241513221/display_1500/stock-vector-food-burger-and-french-fries-social-media-post-design-template-2241513221.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1346026241/display_1500/stock-vector-hamburger-ads-design-on-blackboard-background-in-d-illustration-1346026241.jpg',
    'https://www.shutterstock.com/shutterstock/photos/1804330342/display_1500/stock-vector-delicious-homemade-burger-with-chili-and-bbq-grill-fire-food-ad-banner-in-d-illustration-1804330342.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Appetizers',
      'image': 'assets/images/starters.jpeg',
    },
    {
      'title': 'Main Course',
      'image': 'assets/images/main_course.jpeg',
    },
    {
      'title': 'Side Dishes',
      'image': 'assets/images/side_dishes.jpeg',
    },
    {
      'title': 'Salads',
      'image': 'assets/images/salads.jpeg',
    },
    {
      'title': 'Soups',
      'image': 'assets/images/soups.jpeg',
    },
    {
      'title': 'Wraps',
      'image': 'assets/images/wraps.jpeg',
    },
    {
      'title': 'Desserts',
      'image': 'assets/images/desserts.jpeg',
    },
    {
      'title': 'Beverages',
      'image': 'assets/images/beverages.jpeg',
    },
    {
      'title': 'Specials',
      'image': 'assets/images/specials.jpeg',
    },
  ];
}
