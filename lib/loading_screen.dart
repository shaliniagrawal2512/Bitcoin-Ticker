import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'services.dart';
import 'price_screen.dart';

String apiKey = '805763AB-A39C-46AE-A6C8-C3EB5A29020A';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    Service data = Service(
        'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=%20$apiKey');
    double price = await data.getRates();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PriceScreen(rates: price);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.blueGrey,
          size: 100.0,
        ),
      ),
    );
  }
}
