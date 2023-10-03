// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sundari/common/widgets/custom_button.dart';
import 'package:sundari/constants/global_variables.dart';
import 'package:sundari/constants/notification_service.dart';
import 'package:sundari/features/admin/services/admin_services.dart';
import 'package:sundari/features/search/screens/search_screen.dart';
import 'package:sundari/models/order.dart';
import 'package:sundari/providers/user_provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/order-details';
  final Order order;
  const OrderDetailsScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  int currentStep = 0;
  int localStatus = 0;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    if (widget.order.status > 3) {
      currentStep = 3;
    } else {
      currentStep = widget.order.status;
    }
    localStatus = widget.order.status;
  }

  void changeOrderStatus(int status) {
    adminServices.changeOrderStatus(
        context: context,
        status: status,
        order: widget.order,
        onSuccess: () {
          setState(() {
            if (currentStep < 3) {
              currentStep += 1;
            }
            localStatus += 1;
            NotificationsServices().sendNotification('Delta',
                "Congratulation!! Your order status changed, you are much more close to your order");
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 6,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(
                            top: 10,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black38,
                              width: 1,
                            ),
                          ),
                          hintText: 'Search Delta.in',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 23,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View Order Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Order Date:        ${DateFormat().format(DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt))}'),
                    Text(
                      'Order ID:          ${widget.order.id}',
                    ),
                    Text(
                      'Total Price:       ₹${widget.order.totalPrice}',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Purchase Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 150,
                            width: 150,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  widget.order.products[i].name,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  'Qty: ${widget.order.quantity[i].toString()}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Tracking',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Stepper(
                  currentStep: currentStep,
                  controlsBuilder: (context, details) {
                    if (user.type == 'admin') {
                      if (localStatus <= 3) {
                        return CustomButton(
                          text: 'Done',
                          onTap: () => changeOrderStatus(details.currentStep),
                        );
                      }
                    }
                    return const SizedBox();
                  },
                  steps: [
                    Step(
                        title: const Text('Pending'),
                        content:
                            const Text('Your order is yet to be delivered.'),
                        isActive: currentStep >= 0,
                        state: localStatus > 0
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('Completed'),
                        content: const Text(
                            'Your order has been delivered. You are yet to sign.'),
                        isActive: currentStep >= 1,
                        state: localStatus > 1
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('Received'),
                        content: const Text(
                            'Your order has been to be delivered and signed by you.'),
                        isActive: currentStep >= 2,
                        state: localStatus > 2
                            ? StepState.complete
                            : StepState.indexed),
                    Step(
                        title: const Text('Delivered'),
                        content: const Text(
                            'Your order has been to be delivered and signed by you.'),
                        isActive: currentStep >= 3,
                        state: localStatus > 3
                            ? StepState.complete
                            : StepState.indexed),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
