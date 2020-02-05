import 'package:bitcoin_ticker/services/networking.dart';

const apiKey = 'XYZ'; //@todo  insert a valid coinapi.io apiKey
const apiUrl = 'https://rest.coinapi.io/v1/exchangerate';

class ExchangeModel {
  Future<dynamic> getExchange(String from, String to) async {
    var url = '$apiUrl/$from/$to';

    NetworkHelper networkHelper =
        NetworkHelper(url: url, headers: {'X-CoinAPI-Key': apiKey});

    return await networkHelper.getData();
  }
}
