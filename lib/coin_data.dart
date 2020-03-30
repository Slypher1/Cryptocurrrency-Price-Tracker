import 'services/networking.dart';

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

const apiKey = 'INSERT-YOUR-APIKEY-HERE';
const coinApiURL = 'https://rest.coinapi.io/v1/exchangerate/';

class CoinData {
  Future<dynamic> getCoinData(String crypto, String currency) async {
    NetworkHelper networkHelper = NetworkHelper('$coinApiURL$crypto/$currency?apikey=$apiKey');
    var rateData = await networkHelper.getData();
    return rateData;
  }
}
