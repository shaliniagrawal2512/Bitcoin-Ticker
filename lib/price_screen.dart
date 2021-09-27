import 'package:bitcoin_ticker/crypto_screen.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'services.dart';

String apiKey = '805763AB-A39C-46AE-A6C8-C3EB5A29020A';

class PriceScreen extends StatefulWidget {
  PriceScreen({
    @required this.rates,
  });
  final double rates;
  @override
  _PriceScreenState createState() => _PriceScreenState(currencyPrice: rates);
}

class _PriceScreenState extends State<PriceScreen> {
  _PriceScreenState({@required this.currencyPrice});
  double currencyPrice;
  String selectedCurrency = 'USD';
  String selectedCrypto = 'BTC';
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
          child: Text(
            currency,
            style: TextStyle(fontSize: 20.0),
          ),
          value: currency);
      dropDownItems.add(item);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          changePrice();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerList = [];
    for (String currency in currenciesList) {
      pickerList.add(Text(
        currency,
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 40.0,
      onSelectedItemChanged: (value) {
        setState(() {
          selectedCurrency = pickerList[value].data;
          changePrice();
        });
      },
      children: pickerList,
    );
  }

  changePrice() async {
    Service data = Service(
        'https://rest.coinapi.io/v1/exchangerate/$selectedCrypto/$selectedCurrency?apikey=%20$apiKey');
    currencyPrice = await data.getRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        actions: [
          FlatButton(
              onPressed: () async {
                String crypto = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return CryptoScreen();
                }));
                setState(() {
                  if (crypto != null) selectedCrypto = crypto;
                  changePrice();
                });
              },
              child: Icon(Icons.art_track))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $selectedCrypto = $currencyPrice $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Image.asset('images/Untitled design.png'),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
