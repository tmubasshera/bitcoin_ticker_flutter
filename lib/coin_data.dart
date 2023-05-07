import 'package:http/http.dart' as http;
import 'dart:convert';
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

const String apiKey = '9395B177-7DCA-4D59-B832-7230E5141098';
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
class CoinData{
  

  Future getCoinData(String fiatCurrency, String cryptoCurrency) async{

    String requestURL ='$coinAPIURL/$cryptoCurrency/$fiatCurrency?apikey=$apiKey';
    http.Response response = await http.get(requestURL);

    //checking if i get a real value in response object
    if (response.statusCode==200){
       var decodedData = jsonDecode(response.body);
       return decodedData['rate'];
    }else {
      print(response.statusCode);
      throw 'problem with the get request';
    }

  }
}