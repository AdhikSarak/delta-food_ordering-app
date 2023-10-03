import 'package:flutter/material.dart';
import 'package:sundari/common/widgets/loader.dart';
import 'package:sundari/constants/global_variables.dart';
import 'package:sundari/features/account/services/account_services.dart';
import 'package:sundari/features/account/widgets/single_product.dart';
import 'package:sundari/features/order_details/screens/order_details_screen.dart';
import 'package:sundari/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final AccountServices accountServices = AccountServices();
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  void navigateToOrderDetailsScreen(Order order) {
    Navigator.pushNamed(context, OrderDetailsScreen.routeName, arguments: order);
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: GlobalVariables.selectedNavBarColor,
                      ),
                    ),
                  ),
                ],
              ),
              //Display Orders
              Container(
                height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
                child: ListView.builder(
                  
                    scrollDirection: Axis.horizontal,
                    itemCount: orders!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () => navigateToOrderDetailsScreen(orders![index]),
                          child: SingleProduct(
                            image: orders![index].products[0].images[0],
                          ));
                    }),
              ),
            ],
          );
  }
}
