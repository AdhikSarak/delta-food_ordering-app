import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sundari/constants/error_handling.dart';
import 'package:sundari/constants/global_variables.dart';
import 'package:sundari/constants/notification_service.dart';
import 'package:sundari/constants/utils.dart';
import 'package:sundari/models/product.dart';
import 'package:sundari/models/user.dart';
import 'package:sundari/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        body: jsonEncode({
          'id': product.id!,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(res.body)['cart'],
          );
          userProvider.setUserFromModel(user);
          NotificationsServices().sendNotification(
              "Delta", "Food items successfully added to the cart");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
