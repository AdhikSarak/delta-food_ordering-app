// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import 'package:sundari/common/widgets/custom_textfield.dart';
import 'package:sundari/constants/global_variables.dart';
import 'package:sundari/constants/notification_service.dart';
import 'package:sundari/constants/utils.dart';
import 'package:sundari/features/address/services/address_services.dart';
import 'package:sundari/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController flatBuildingController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  String addressToBeUsed = '';
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();
  NotificationsServices notificationsServices = NotificationsServices();

  void onGooglePayResult(result) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
    // notificationsServices.sendNotification(
    //     'Delta', "Congratulations!! Your order has been placed successfully");
  }

  void onApplePayResult(result) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void payPressed(String addressFormProvider) {
    addressToBeUsed = '';

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        throw Exception('Please Enter all the values!!');
      }
    } else if (addressFormProvider.isNotEmpty) {
      addressToBeUsed = addressFormProvider;
    } else {
      showSnackBar(context, 'ERROR');
      throw Exception('Please Enter all the values!!');
    }
  }

  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');

  final Future<PaymentConfiguration> _applePayConfigFuture =
      PaymentConfiguration.fromAsset('applepay.json');

  @override
  void initState() {
    super.initState();
    notificationsServices.initialiseNotifications();
    paymentItems.add(PaymentItem(
      amount: widget.totalAmount,
      label: 'Total Amount',
      status: PaymentItemStatus.final_price,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    //var address = 'At Mirgaon';
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: flatBuildingController,
                      hintText: "Flat, House No., Building",
                      prefixIcon: const Icon(Icons.route_outlined),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: areaController,
                      hintText: "Area, Street",
                      prefixIcon: const Icon(Icons.route_outlined),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: pincodeController,
                      hintText: "Pincode",
                      prefixIcon: const Icon(Icons.route_outlined),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: cityController,
                      hintText: "Town, City",
                      prefixIcon: const Icon(Icons.route_outlined),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              FutureBuilder<PaymentConfiguration>(
                future: _googlePayConfigFuture,
                builder: (context, snapshot) => snapshot.hasData
                    ? GooglePayButton(
                        onPressed: () => payPressed(address),
                        width: double.infinity,
                        height: 50,
                        type: GooglePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15),
                        paymentConfiguration: snapshot.data!,
                        paymentItems: paymentItems,
                        onPaymentResult: onGooglePayResult,
                      )
                    : const SizedBox.shrink(),
              ),
              FutureBuilder<PaymentConfiguration>(
                future: _applePayConfigFuture,
                builder: (context, snapshot) => snapshot.hasData
                    ? ApplePayButton(
                        onPressed: () => payPressed(address),
                        height: 50,
                        margin: const EdgeInsets.only(top: 15),
                        width: double.infinity,
                        style: ApplePayButtonStyle.whiteOutline,
                        type: ApplePayButtonType.buy,
                        paymentConfiguration: snapshot.data!,
                        paymentItems: paymentItems,
                        onPaymentResult: onApplePayResult,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
