import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {

  int currencyValue;
  String selectedCurrency;
  String fromCurrency;

  CurrencyCard({@required this.currencyValue,@required this.selectedCurrency,@required this.fromCurrency});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $fromCurrency = $currencyValue $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

