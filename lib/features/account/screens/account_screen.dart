import 'package:flutter/material.dart';
import 'package:sundari/constants/global_variables.dart';
import 'package:sundari/features/account/widgets/below_app_bar.dart';
import 'package:sundari/features/account/widgets/orders.dart';
import 'package:sundari/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Container(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/images/full_logo_bg.png', 
                width: 120,
                height: 45,
                color: Colors.black,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            BelowAppBar(),
            SizedBox(height: 10,),
            TopButtons(),
            SizedBox(height: 20,),
            Orders(),
          ],
        ),
      ),
    );
  }
}