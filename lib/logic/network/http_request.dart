import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:kaltani_ms/logic/local_storage.dart';
import 'package:path/path.dart';

import '../../utils/api_routes.dart';
import '../../utils/null_checker.dart';
import 'exceptions.dart';

final String baseUrl = '';

Future<Map<String, String>> getHeader() async {
  String token = await getUserToke();

  var header = {
    'Content-Type': 'application/json',
  };
  if (isNotEmpty(token)) {
    header['Authorization'] = 'Bearer $token';
  }
  return header;
}

const IS_PRODUCTION = kReleaseMode;
// const IS_PRODUCTION = kDebugMode;

class ServerData {
  dynamic requestBody;

  void logToSlack(http.Response response) async {
    if (!IS_PRODUCTION) return;
    var email = await getUserEmail();
    String? userEmail = isEmpty(email) ? "ANONYMOUS" : email;
    String platform = Platform.isIOS ? "iOS" : "Android";
    ServerData().postVerb(APIRoute.logToSlack, body: {
      'text': "'url': ${response.request?.url.toString()},\n"
          "'statusCode': ${response.statusCode},\n"
          "'method': ${response.request?.method}\n"
          "'userEmail': $userEmail\n"
          "'device': $platform\n"
          "'body': ${response.body},\n"
    });
  }

  Future<dynamic> postVerb(String route, {dynamic body}) async {
    if (body != null && body != "") {
      requestBody = body;
    }
    log(jsonEncode(body));
    log("ROUTE: $route");
    try {
      final response = await http.post(Uri.parse(route),
          headers: await getHeader(), body: jsonEncode(body));

      log('POST ${response.statusCode}');
      log(response.body);
      // not authorize need to sign in
      if (response.statusCode == 401) {
        await clearUser();
        Get.toNamed('/');
        return;
      }
      return response;
    } on SocketException {
      return http.Response(
          jsonEncode({
            "title": "No Internet connection",
          }),
          500);
    } on HttpException {
      return http.Response(
          jsonEncode({
            "title": "Network error",
          }),
          500);
    } on FormatException {
      return http.Response(
          jsonEncode({
            "title": "Bad response format",
          }),
          500);
    }
  }

  static Future<dynamic> getVerb(
    String route,
  ) async {
    try {
      final headers = await getHeader();
      final response = await http.get(Uri.parse(route), headers: headers);
      log('ROUTE $route');
      log('POST ${response.statusCode}');
      log(response.body);
      if (response.statusCode == 401) {
        await clearUser();
        Get.toNamed('/');
        return;
      }
      return response;
    } on SocketException {
      return http.Response(
          jsonEncode({
            "title": "No Internet connection",
          }),
          500);
    } on HttpException {
      return http.Response(
          jsonEncode({
            "title": "Network error",
          }),
          500);
    } on FormatException {
      return http.Response(
          jsonEncode({
            "title": "Bad response format",
          }),
          500);
    }
  }

  Future<HttpResponse> getData({
    String? path,
  }) async {
    var response = await getVerb(path!);
    var result = await parseResponse(response);
    return HttpData(result);
    // try {
    //   var response = await http.get(Uri.parse(path!), headers: header);
    //   var data = jsonDecode(response.body);
    //   log(">>>>>>>>>>>>>>>>>>>>>>>RESPONSE>>>>>>>>>>>>>>>>>>");
    //   log("route: $path \n ${response.body}");
    //
    //   if (response.statusCode == 200 || response.statusCode == 201) {
    //     return HttpData(data);
    //   } else {
    //     return HttpData(data);
    //   }
    // } catch (e) {
    //   print('exception get $e');
    //   return HttpException('something wrong happened');
    // }
  }

  Future<HttpResponse> postData(
      {String? path, Map? body, List<Map>? bodyII}) async {
    var response = await postVerb(path!, body: body ?? bodyII);
    var result = await parseResponse(response);
    return HttpData(result);
  }

  Future putData(BuildContext context,
      {String? path, Map? body, List<Map>? bodyII}) async {
    var header = await getHeader();
    print(path);

    try {
      var response = await http.put(Uri.parse(path!),
          body: json.encode(body ?? bodyII), headers: header);
      print(body);

      var data = jsonDecode(response.body);

      // print("$data  route: $path");
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("cool");
        print("cool$data");

        return HttpData(data);
      } else {
        print("oops");
        print(response.statusCode);

        print(data);
        return HttpData(data);
      }
    } catch (e) {
      print('exception post $e.');
      return HttpException(
          {"message": 'something wrong happened', "error": true});
    }
  }

  Future uploadNoFile(
    BuildContext context, {
    String? path,
    Map? body,
  }) async {
    final header = await getHeader();
    var postUri = Uri.parse('$baseUrl$path');
    var request = http.MultipartRequest(
      "POST",
      postUri,
    );
    request.headers.addAll(header);

    body!.forEach((key, value) {
      // print('$key $value');
      request.fields['$key'] = value.toString();
    });

    var response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());

    print(response);
    if (response.statusCode == 401) {}
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('successful');
      return HttpData(data["data"]);
      // return true;
    } else {
      print('fails');
      return HttpException(null);
    }
  }
  //

  Future uploadFile(BuildContext context,
      {String? path, Map? body, File? file, imageKey}) async {
    var stream = new http.ByteStream(DelegatingStream.typed(file!.openRead()));
    var length = await file.length();
    final header = await getHeader();
    var postUri = Uri.parse('$baseUrl$path');
    var request = http.MultipartRequest(
      "POST",
      postUri,
    );
    request.headers.addAll(header);

    body!.forEach((key, value) {
      request.fields['$key'] = value.toString();
    });
    var multipartFileSign = new http.MultipartFile(imageKey, stream, length,
        filename: basename(file.path));
    request.files.add(multipartFileSign);

    var response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 401) {}

    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('successful');
      return HttpData(data["data"]);
      // return true;
    } else {
      print('fails');
      return HttpException(null);
    }
  }

  Future<HttpResponse> deleteData(
    BuildContext context, {
    String? path,
  }) async {
    var header = await getHeader();

    try {
      var response = await http.delete(Uri.parse(path!), headers: header);
      var data = jsonDecode(response.body);
      print("$data  route: $path");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpData(data);
      } else {
        return HttpData(data);
      }
    } catch (e) {
      print('exception get $e');
      return HttpException('something wrong happened');
    }
  }

  static dynamic parseResponse(http.Response response) async {
    Map<String, dynamic> responseBody = {};
    try {
      responseBody = json.decode(response.body);
    } catch (ex) {
      if (ex is FormatException) {
        ServerData().logToSlack(response);
        throw BadFormatException();
      }
    }
    if (response.statusCode < 200 || response.statusCode >= 400) {
      switch (response.statusCode) {
        case 503:
          ServerData().logToSlack(response);
          throw NotFoundException("Service unavailable", 0);
        default:
          ServerData().logToSlack(response);
          throw BadRequestException(
            responseBody['title'] ?? "Something went wrong",
            0,
          );
      }
    }
    return responseBody;
  }
}

//request  http request

abstract class HttpResponse {
  dynamic data;
}

class HttpException extends HttpResponse {
  final data;

  HttpException(this.data);
}

class HttpData extends HttpResponse {
  final data;

  HttpData(this.data);
}
