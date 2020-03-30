import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'crypto_card.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  CoinData coinData = CoinData();
  String rate = '?';

  Map<String, String> rates = {};
  String selectedCurrency = 'USD';

  DropdownButton<String> androidDropdown() {

    List<DropdownMenuItem<String>> dropdownItems = [];

    for(String currency in currenciesList) {
      var newItem =  DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getData(selectedCurrency);
      },
      children: pickerItems,
    );
  }

  Column card() {
    List<Widget> listRate = [];

    for(String crypto in cryptoList){
      listRate.add(CryptoCard(
        crypto: crypto,
        currency: selectedCurrency,
        rate: rates[crypto] == null ? '?' : rates[crypto],
      ));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: listRate,
    );
  }

  @override
  void initState() {
    super.initState();
    getData(selectedCurrency);
  }

  Future<void> getData(String currency)  async {
    try{
      for(String crypto in cryptoList) {
        var rateData = await coinData.getCoinData(crypto, currency);
        double rateDouble = rateData['rate'];
        rate = (rateDouble.toInt()).toString();
        setState(() {
          rates[crypto] = rate;
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          card(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}