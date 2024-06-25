import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fechos/constant/api_path.dart';
import 'package:fechos/constant/enums.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ServiceData{
  static Future statusError(request) async {
    try {
      final response = await request.timeout(const Duration(seconds: 60), onTimeout: () {
        throw TimeoutException('The connection has timed out , Please try again!');
      });
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      }
      if (response.statusCode == 401) {
        return ErrorRequest.internet;
      } else {
        return ErrorRequest.serverError;
      }
    } on SocketException {
      return ErrorRequest.internet;
    } on TimeoutException {
      return ErrorRequest.timeOut;
    } on Exception {
      return ErrorRequest.serverError;
    }
  }

  static Future getService(url) async {
    print(ApiPath.baseUrl + url);
    var response = await statusError(http.get(Uri.parse(ApiPath.baseUrl + url), headers: {
      // 'Authorization': 'Bearer ${globals.user.token}',
       "Content-Type":"application/json",
      //
      // 'Content-type': 'text/plain',
    }));
    print("serv");
    //print(response);
    // final jsonData = json.decode(response.body);
    // print(jsonData);
    if (response.runtimeType == ErrorRequest) {
      requestAlertError(response);

      return null;
    }
    return response;
  }



//   static Future<dynamic> getService2(String url) async {
//     try {
//       final response = await http.get(Uri.parse(ApiPath.baseUrl + url));
// print("object");
//       if (response.statusCode == 200) {
//         // O JSON foi buscado com sucesso.
//         final jsonData = json.decode(response.body);
//         // Agora, jsonData contém o JSON que você recebeu.
//         print(jsonData);
//         print("jsonData");
//       } else {
//         // Lidar com códigos de status HTTP diferentes de 200 conforme necessário.
//         print('Falha na solicitação: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Lidar com exceções, se ocorrerem.
//       print("tes1");
//       print('Erro durante a solicitação: $e');
//       print("tes2");
//     }
//   }

  static Future putService(List<Map<String, dynamic>> body, url) async {
    print("put");
    print(body);
    print(ApiPath.baseUrl + url);
    final response = await statusError(http.put(Uri.parse(ApiPath.baseUrl + url), headers: {"Content-Type": "application/json"}, body: jsonEncode(body)));

    // print(response.body);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      return response.statusCode;
    }
  }

  static Future putService2(List<Map<String, dynamic>> body, url) async {
    print(ApiPath.baseUrl + url);
    print(body);
    final response = await http.put(Uri.parse(ApiPath.baseUrl + url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body));

    if (response.statusCode == 201 || response.statusCode == 200) {
      final jsonString = response.body;
      final jsonData = json.decode(jsonString);
      return jsonData;
    } else {
      return null;
    }
  }

  static Future postService(List<Map<String, dynamic>> body, url) async {

    print(json.encode(body));
    print(ApiPath.baseUrl + url);
    final response = await statusError(http.post(
      Uri.parse(ApiPath.baseUrl + url),
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
      },
    ));
    // Get.back();
    print("1");
    if (response.runtimeType == ErrorRequest) {
      requestAlertError(response);
      return null;
      // return Get.snackbar("SolAtlantico", "server error");
    }
    return response;
  }

  static Future postCreate(List<Map<String, dynamic>> body, url) async {
    print(json.encode(body));
    print(ApiPath.baseUrl + url);
    final response = await http.post(
      Uri.parse(ApiPath.baseUrl + url ),
      headers: {
        "Content-Type": "application/json",
        //
        // 'Content-type': 'text/plain',
      },
      body: jsonEncode(body),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      //final responseData = json.decode(response.body);
      return response.body;
    }
    return null;
  }

  static requestAlertError(ErrorRequest errorRequest) async {
    switch (errorRequest) {
      case ErrorRequest.timeOut:
        Get.snackbar("SolAtlantico", "The connection has timed out, Please try again!");
        break;
      case ErrorRequest.internet:
        Get.snackbar("SolAtlantico", "No internet connection");
        break;
      case ErrorRequest.serverError:
        Get.snackbar("SolAtlantico", "Oops, unexpected error! Try again");
        break;
    }
  }


}