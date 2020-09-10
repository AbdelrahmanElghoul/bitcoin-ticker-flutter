import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/utils/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'currency_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency='AUD';
  int BTCValue = 0;
  int LTCValue = 0;
  int ETHValue = 0;
  Widget picker;

  List<DropdownMenuItem<String>> dropDownList;
  DropdownButton androidDropdown() {
    dropDownList = [];
    for (String currency in currenciesList)
      dropDownList.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownList,
      onChanged: (v) => setState(() {
        selectedCurrency = v;
        print('new value =$selectedCurrency');
        updateUI();
      }),

    );
  }

  void updateUI() async {
    Network network = Network();
    await network.data(selectedCurrency);
    setState(() {
      BTCValue = network.btc.round();
      LTCValue = network.ltc.round();
      ETHValue = network.eth.round();
    });
  }

  List<Text> pickerList;
  CupertinoPicker IOSPicker() {
    pickerList = [];
    for (String currency in currenciesList) pickerList.add(Text(currency));

    return CupertinoPicker(
        looping: false,
        backgroundColor: Colors.lightBlue,
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex) {
          setState(() {
            selectedCurrency = pickerList[selectedIndex].data;
            updateUI();
          });
        },
        children: pickerList);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPicker();
    updateUI();

  }

  void setPicker() {
    picker = Platform.isIOS ? IOSPicker() : androidDropdown();
      selectedCurrency =
      Platform.isIOS ? pickerList[0].data : dropDownList[0].value;
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CurrencyCard(
                  currencyValue: BTCValue,
                  selectedCurrency: selectedCurrency,
                  fromCurrency: 'BTC',
                ),
                CurrencyCard(
                  currencyValue: LTCValue,
                  selectedCurrency: selectedCurrency,
                  fromCurrency: 'LTC',
                ),
                CurrencyCard(
                  currencyValue: ETHValue,
                  selectedCurrency: selectedCurrency,
                  fromCurrency: 'ETH',
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: picker,
          ),
        ],
      ),
    );
  }
}
