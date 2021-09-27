import 'package:flutter/material.dart';
import 'coin_data.dart';

class CryptoScreen extends StatefulWidget {
  @override
  _CryptoScreenState createState() => _CryptoScreenState();
}

class _CryptoScreenState extends State<CryptoScreen> {
  Widget getCurrency(String crypto) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: FlatButton(
          onPressed: () {
            Navigator.pop(context, crypto);
          },
          child: Text(
            crypto,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getWidget() {
    List<Widget> currencies = [];
    for (String crypto in cryptoList) {
      currencies.add(getCurrency(crypto));
    }
    return currencies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('🤑 Coin Ticker'),
        ),
        body: SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(
              //minHeight: viewportConstraints.maxHeight,
              ),
          child: IntrinsicHeight(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: getWidget(),
            ),
          ),
        )));
  }
}
