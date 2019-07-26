import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_supplier/Pages/Toast.dart';
import 'package:redis/redis.dart';
import 'package:shared_preferences/shared_preferences.dart';

String baseUrl="http://192.168.31.56:8088";


bool debug = true;// 控制是否打印调试内容

Future<Object> post(url, data,
    {headers, bool resultStr, bool isForm = false}) async {
  BaseOptions options = BaseOptions(
      method: 'post',
      contentType: ContentType.parse("application/x-www-form-urlencoded"),
      headers: headers == null
          ? {
        'pid': -1,
      }
          : headers);
  Dio dio = new Dio(options);
  if (isForm) {
    data = FormData.from(data);
  }
  Response resp = await dio.post(
    url,
    data: data,
  );
  if (debug) {
    print("url: $url\n请求参数:$data \n请求结果:$resp");
  }
  Map<String, dynamic> respMap =
  resp.data is String ? json.decode(resp.data) : resp.data;
  if (debug) {
    print("url: $url \n请求返回代号:${respMap['code']}\n请求参数:$data \n请求结果:$resp");
  }
  if (resp.statusCode != 200) {
    Toast.show("网络异常");
  }
  if (resp.statusCode == 500) {
    // TODO: 采集异常
  }
  if (respMap['code'] != 0) {
    Toast.show(respMap['msg']);
    throw new Exception(respMap['msg']);
  }
  if (resultStr != null && resultStr) {
    return respMap["data"];
  }
  return respMap["data"] is String
      ? json.decode(respMap["data"])
      : respMap["data"];



}


Map<String,String> models={
  "user":baseUrl+"/api/construction"
};


Map<String,String> userModel={
  "getAccountPassword":models['user']+"/getAccountPassword"
};


///用户登录请求后台方法
Future<Map<String,dynamic>> login(String username,String password,String tokens) async{
  Map<String, dynamic> userMap=await
  post(userModel['getAccountPassword'],{"username":username,"password":password,"toKens":tokens});
  SharedPreferences prefs = await SharedPreferences.getInstance();
    if(userMap!=null){
      if(userMap["supplierToKen"]!=""||userMap["supplierToKen"]!=null){
        prefs.setString("toKens",userMap["supplierToKen"]);
      }
      return userMap;
    }
    return userMap;
}











