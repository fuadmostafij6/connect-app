import 'package:aamarpay/aamarpay.dart';
import 'package:flutter/material.dart';

class AmarpayPage extends StatefulWidget {
  const AmarpayPage({Key? key}) : super(key: key);

  @override
  State<AmarpayPage> createState() => _AmarpayPageState();
}

class _AmarpayPageState extends State<AmarpayPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Aamarpay(
          returnUrl: (url) {
            print(url);
          },
          isLoading: (v) {
            setState(() {
              isLoading = v;
            });
          },
          paymentStatus: (status) {
            print(status);
          },
          status: (EventState event, String message) {
            if (event == EventState.error) {
              print(message);
              setState(() {
                isLoading = false;
              });
            }
          },
          cancelUrl: "example.com/payment/cancel",
          successUrl: "example.com/payment/confirm",
          failUrl: "example.com/payment/fail",
          customerEmail: "masumbillahsanjid@gmail.com",
          customerMobile: "01834760591",
          customerName: "Masum Billah Sanjid",
          signature: "dbb74894e82415a2f7ff0ec3a97e4183",
          storeID: "aamarpaytest",
          transactionAmount: "100",
          transactionID: "transactionID9",
          description: "test",
          isSandBox: true,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: Colors.orange,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Payment",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
