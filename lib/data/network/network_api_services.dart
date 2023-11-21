import 'dart:convert';
import 'dart:io';
import 'package:either_dart/either.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:propertify/data/exceptions/app_exceptions.dart';
import 'package:propertify/utils/type_def.dart';

class ApiServices {

  
  static final _headers = {'Content-Type':'application/json'};


  //Post Api
  static EitherResponse<Map> postApi(var data, String apiurl) async {
    if(kDebugMode){
      print('ApiUrl:$apiurl');
      print('Data:$data');

    }
    Map FetchedData = {};
    final url = Uri.parse(apiurl);
    final body = jsonEncode(data);
    try {
      final response =  await http.post(url,body: body,headers: _headers);
      FetchedData = getResponse(response);

    } catch (e) {
      return Left(e as AppException);
    }
    return Right (FetchedData);
  }
  //Get Api
  static EitherResponse<Map> getApi (String apiurl) async {
    final url = Uri.parse(apiurl);
    Map<String, dynamic> fetchedData = {};
     
    print('In Api Service');
    try {
      final response = await http.get(url);
      fetchedData = getResponse(response);
      print('111');
    } on SocketException {
      return Left(InternetException());
    } on http.ClientException {
      return Left(RequestTimeOUtException());
    } catch (e) {
      return Left(e as AppException);
    }
    // if(kDebugMode){
    //   print('ApiUrl:$apiurl');
    //   print('Data:$fetchedData');

    // }
    return Right(fetchedData);
  }

  //Put Api
  // Put Api
static EitherResponse<Map> putApi(var data, String apiurl) async {
  if (kDebugMode) {
    print('ApiUrl: $apiurl');
    print('Data: $data');
  }

  Map<String, dynamic> fetchedData = {};
  final url = Uri.parse(apiurl);

  try {
    final response = await http.put(
      url,
      body: data.isNotEmpty ? jsonEncode(data) : null,
      headers: _headers,
    );

    fetchedData = getResponse(response);
  } catch (e) {
    return Left(e as AppException);
  }

  return Right(fetchedData);
}






  //Responses
  static Map<String,dynamic> getResponse(http.Response response) {
    switch(response.statusCode) {
      case 200:
        return (jsonDecode(response.body));
      case 400:
        throw BadRequestException();
      default:
        throw BadRequestException();
    }
  }
}