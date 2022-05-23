import 'dart:async';

import 'package:convert_app/view/convert_card.dart';
import 'package:flutter/material.dart';
import 'package:convert_app/func/fetch_data.dart';
import 'package:convert_app/model/rates_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color mainColor = Color(0xFF212936);

  late Future<Rates> rates;
  late Future<Map> currencies;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      rates = fetchrates();
      currencies = fetchcurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: Text('Currency Calculator',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          key: formkey,
                          child: FutureBuilder<Rates> (
                            future: rates,
                            builder: (context, rate_snapshot) {
                              if (rate_snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              return Center(
                                child: FutureBuilder<Map> (
                                  future: currencies,
                                  builder: (context, currency_snapshot) {
                                    if (currency_snapshot.connectionState == ConnectionState.waiting) {
                                      return Center(child: CircularProgressIndicator());
                                    }
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ConvertCurrency(
                                          currencies: currency_snapshot.data!,
                                          rates: rate_snapshot.data!.rates,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
