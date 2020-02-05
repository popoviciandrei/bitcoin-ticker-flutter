// load only the Platform packages form inside dart:io
import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  /**
   * Render android dropdown style
   */
  DropdownButton<String> androidDropdown() {
    return DropdownButton<String>(
        value: selectedCurrency,
        items: currenciesList
            .map(
              (currency) => DropdownMenuItem(
                child: Text(currency),
                value: currency,
              ),
            )
            .toList(),
        onChanged: (value) => setState(() => selectedCurrency = value));
  }

  /**
   * Render iOs picker list
   */
  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
      //squeeze: 2,

      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) =>
          setState(() => selectedCurrency = currenciesList[selectedIndex]),
      children: currenciesList
          .map((currency) => Text(
                currency,
                style: TextStyle(color: Colors.white),
              ))
          .toList(),
    );
  }

  Widget getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else {
      return androidDropdown();
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
                  '1 BTC = ? $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          )
        ],
      ),
    );
  }
}
