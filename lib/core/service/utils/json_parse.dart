// import 'dart:convert';
//
// import 'package:flutter/services.dart';
//
//
// class HYJsonParse {
//   static Future<List<HYCategoryModel>> getCategoryData() async{
//     //1、加载json文件,loadString返回的类型是Future，所以是异步操作
//     final jsonString = await rootBundle.loadString("assets/json/category.json");
//
//     /**
//      * decode解析，即将json转成map或list;
//      * encode则反过来
//      */
//     //2、将jsonString转成Map/List
//     final result = json.decode(jsonString);
//
//     //3、将Map中的内哦荣转成一个个的对象
//     final resultList = result["category"];
//     List<HYCategoryModel> categories = [];
//     for (var json in resultList) {
//       categories.add(HYCategoryModel.fromJson(json));
//     }
//     return categories;
//   }
// }