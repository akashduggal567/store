

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:store/helpers/constants.dart';
import 'package:store/ui/views/buy/buy_viewModel.dart';

class BuyView extends StatefulWidget {
  @override
  _BuyViewState createState() => _BuyViewState();
}

class _BuyViewState extends State<BuyView> {
  Razorpay razorpay;
  var options = {
    'key': 'rzp_test_zyFEEKwvRXqFH3',
    'amount': 100,
    'name': 'Acme Corp.',
    'description': 'Fine T-Shirt',
    'prefill': {
      'contact': '8888888888',
      'email': 'test@razorpay.com'
    },
    'external':{
      'wallets': ['paytm']
    }
  };

  @override
  void initState() {
    // TODO: implement initState
     razorpay = Razorpay();

     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment successfull");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment error");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("Payment Wallet Successful");
  }
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BuyViewModel>.nonReactive(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Color(0xff00ADB5)),
            backgroundColor: Colors.black,
            title: Text("Buy"),
          ),
          backgroundColor: Colors.black,
          body: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 150,
                      child: Center(
                        child: Text(
                          "You're Just One Step Away!",
                          style: TextStyle(
                            color: Constants.offWhiteColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 26,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Constants.lightBlackColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.credit_card,
                                  color: Colors.black,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Text("Debit Card",
                                    style: TextStyle(
                                      color: Constants.offWhiteColor,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Constants.lightBlackColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                              AssetImage("assets/images/paytm-logo.png"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Text("Paytm",
                                    style: TextStyle(
                                      color: Constants.offWhiteColor,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Constants.lightBlackColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/bhim-logo.png'),
                                        fit: BoxFit.scaleDown
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Text("Bhim UPI",
                                    style: TextStyle(
                                      color: Constants.offWhiteColor,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Constants.lightBlackColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('assets/images/gpay-logo.png'),
                                        fit: BoxFit.scaleDown
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Text("Google Pay",
                                    style: TextStyle(
                                      color: Constants.offWhiteColor,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Constants.lightBlackColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.home,color: Colors.black,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: Text("Cash On Delivery",
                                    style: TextStyle(
                                      color: Constants.offWhiteColor,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      color: Constants.lightBlackColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.watch_later,color: Colors.black,),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  razorpay.open(options);
                                },
                                child: Container(
                                  child: Text("Pay Later",
                                      style: TextStyle(
                                        color: Constants.offWhiteColor,
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        viewModelBuilder: ()=> BuyViewModel());
  }
}
