import 'package:admin_dashboard/services/local_storege.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FlutterWebApi {

  static Dio _dio = new Dio();

  static void configureDio(){
    //Base del url
    _dio.options.baseUrl = 'http://localhost:8080/api';

    //Configurar Headers
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };

  }

  static Future httpGet( String path ) async {
    try{

      final resp = await _dio.get(path);

      return resp.data;

    }
    catch(e){
      print(e);
      throw('Error en el get');
    }
  }


  static Future post( String path, Map<String, dynamic> data ) async {

    final formdata = FormData.fromMap(data);
    try{

      final resp = await _dio.post(path, data: formdata );

      return resp.data;

    }
    catch(e){
      print(e);
      throw('Error en el POST');
    }
  }

  static Future put( String path, Map<String, dynamic> data ) async {

    final formdata = FormData.fromMap(data);
    try{

      final resp = await _dio.put(path, data: formdata );

      return resp.data;

    }
    catch(e){
      print(e);
      throw('Error en el PUT');
    }
  }

    static Future delete( String path, Map<String, dynamic> data ) async {

    final formdata = FormData.fromMap(data);
    try{

      final resp = await _dio.delete(path, data: formdata );

      return resp.data;

    }
    catch(e){
      print(e);
      throw('Error en el DELETE');
    }
  }

}