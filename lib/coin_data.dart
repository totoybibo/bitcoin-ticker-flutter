import 'package:flutter/material.dart';
import 'network_helper.dart';

const apiKey = '?apiKey=EE967537-636E-48C0-BE90-14338DDB904D';
const baseURL = 'https://rest.coinapi.io/v1/exchangerate';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  final String currency;
  final String base;
  CoinData({@required this.currency, @required this.base});
  Future<String> getRate() async {
    String rate;
    try {
      String url = '$baseURL/$base/$currency/$apiKey';
      print(url);
      NetworkHelper net = NetworkHelper(url);
      dynamic data = await net.getExchangeRate();
      double _rate = data['rate'];
      rate = _rate.toStringAsFixed(3);
    } catch (e) {
      print(e);
    }
    return rate;
  }
}
