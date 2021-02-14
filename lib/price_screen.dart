import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'SGD';
  String rate = '?';
  String selectedBase = 'BTC';
  DropdownButton androidCurrencyDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    currenciesList.forEach((String item) {
      dropdownItems.add(DropdownMenuItem<String>(
          child: Text(item,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          value: item));
    });
    return DropdownButton(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          updateRate(value, selectedBase);
        });
  }

  DropdownButton androidBaseDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    cryptoList.forEach((String item) {
      dropdownItems.add(DropdownMenuItem<String>(
          child: Text(item,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          value: item));
    });
    return DropdownButton(
        value: selectedBase,
        items: dropdownItems,
        onChanged: (value) {
          updateRate(selectedCurrency, value);
        });
  }

  CupertinoPicker iosCurrencyPicker() {
    List<Widget> dropdownItems = [];
    currenciesList.forEach(
      (String item) => dropdownItems.add(
        Text(
          item,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        useMagnifier: true,
        magnification: 1.2,
        itemExtent: 32,
        onSelectedItemChanged: (index) {
          Text data = dropdownItems[index];
          selectedCurrency = data.data;
          updateRate(selectedCurrency, selectedBase);
        },
        children: dropdownItems);
  }

  CupertinoPicker iosBasePicker() {
    List<Widget> dropdownItems = [];
    cryptoList.forEach(
      (String item) => dropdownItems.add(
        Text(
          item,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        useMagnifier: true,
        magnification: 1.2,
        itemExtent: 32,
        onSelectedItemChanged: (index) {
          Text data = dropdownItems[index];
          selectedBase = data.data;
          updateRate(selectedCurrency, selectedBase);
        },
        children: dropdownItems);
  }

  void updateRate(String currency, String base) async {
    CoinData coin = CoinData(currency: currency, base: base);
    String data = await coin.getRate();
    setState(() {
      selectedCurrency = currency;
      selectedBase = base;
      rate = data;
    });
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
                  '1 $selectedBase = $rate $selectedCurrency',
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
            padding: EdgeInsets.only(bottom: 30.0, left: 10, right: 10),
            color: Colors.lightBlue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Platform.isIOS
                        ? iosBasePicker()
                        : androidBaseDropdown()),
                Expanded(
                    child: Platform.isIOS
                        ? iosCurrencyPicker()
                        : androidCurrencyDropdown())
              ],
            ),
          ),
        ],
      ),
    );
  }
}
