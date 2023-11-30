import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/loger.dart';
import '../base/Contant.dart';

class AllRepo {
  Future<Map<String, dynamic>?> getCoinDetails(
      String address, String network) async {
    var param;
    final url =
        'https://api.geckoterminal.com/api/v2/networks/$network/tokens/$address';
    print('url -$url');
    try {
      var request = http.Request('GET', Uri.parse(url));
      print(address);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final res = await response.stream.bytesToString();
        final data = jsonDecode(res);

        if (data['data'] != null) {
          param = {"status": "200", "data": data['data']};
          return param;
        }
      } else {
        param = {"status": "400", "data": "Details not found"};
        return param;
      }
    } catch (e) {
      Logger.logprint('Error --$e');
      param = {"status": "400", "data": "$e"};
      return param;
    }
  }

  Future<Map<String, dynamic>> getCoinInfo(String coinId) async {
    final url = 'https://api.coingecko.com/api/v3/coins/$coinId';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body);
      print(decodedResponse);
      return decodedResponse;
    } else {
      return {"status": "400"};
    }
  }

  Future<Map<String, dynamic>?> getCoinabi(
      String address, String network) async {
    var param;
    if (network == "bsc") {
      final abiUrl =
          'https://${AppContant.bnbbase}/api?module=contract&action=getabi&address=${address}&apikey=${AppContant.bsc_API_KEY}';
      Logger.logprint("url>>>>> $abiUrl");
      var res = await http.get(Uri.parse(abiUrl));
      Map<String, dynamic> reponse = jsonDecode(res.body);
      if (reponse['status'].toString() == '0') {
        param = {
          "status": "400",
          "data": "${reponse['result'].toString()}",
        };
        return param;
      } else {
        param = {
          "status": "200",
          "data": "${reponse["result"]}",
        };
        return param;
      }
    } else {
      final abiUrl =
          'https://${AppContant.tronbalance}/wallet/getcontract?value=${address}&inContract&visible=true';
      print(abiUrl);
      final res = await http.get(Uri.parse(abiUrl));
      final Map<String, dynamic> resMap = jsonDecode(res.body);
      if (resMap.isEmpty) {
        param = {
          "status": "400",
          "data": "Contact not found",
        };
        return param;
      } else {
        param = {
          "status": "200",
          //"data": "${jsonEncode(resMap['abi']['entrys'])}",
          "data": "${jsonEncode(resMap['abi'])}",
        };
        return param;
      }
    }
  }
}
