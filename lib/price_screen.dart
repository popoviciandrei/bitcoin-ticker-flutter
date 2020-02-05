// load only the Platform packages form inside dart:io
import 'dart:io' show Platform;

import 'package:bitcoin_ticker/services/exchange.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String sourceCurrency = 'BTC';
  String exchangeRate = '?';

  ExchangeModel exchangeModel = ExchangeModel();

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
        onChanged: (value) => updateUi(value));
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
          updateUi(currenciesList[selectedIndex]),
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

  void updateUi(String currency) async {
    var exchange =
        await exchangeModel.getExchange(sourceCurrency, selectedCurrency);
    double tmp = exchange['rate'];

    setState(() {
      selectedCurrency = currency;
      exchangeRate = tmp.toInt().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    exchangeModel.getExchange(sourceCurrency, selectedCurrency);
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DisplayExchangeWidget(
              sourceCurrency: sourceCurrency,
              exchangeRate: exchangeRate,
              selectedCurrency: selectedCurrency),
          DisplayExchangeWidget(
              sourceCurrency: sourceCurrency,
              exchangeRate: exchangeRate,
              selectedCurrency: selectedCurrency),
          DisplayExchangeWidget(
              sourceCurrency: sourceCurrency,
              exchangeRate: exchangeRate,
              selectedCurrency: selectedCurrency),
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

class DisplayExchangeWidget extends StatelessWidget {
  const DisplayExchangeWidget({
    Key key,
    @required this.sourceCurrency,
    @required this.exchangeRate,
    @required this.selectedCurrency,
  }) : super(key: key);

  final String sourceCurrency;
  final String exchangeRate;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
          child: Text(
            '1 $sourceCurrency = $exchangeRate $selectedCurrency',
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
}
