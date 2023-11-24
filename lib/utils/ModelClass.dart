import 'dart:ui';

import 'package:flutter/material.dart';

class Asset_Collectibles{


  String? img;
  String? coin_name;
  var coin_cost;
  var coin_bal;
  var coin_rate;
  String? coin_available;
  String? id;
  bool? showmore;
  bool? select;
  var decimalval;

  Asset_Collectibles(
      {this.img,
      this.coin_name,
      this.coin_cost,
      this.id,
      this.coin_bal,
      this.coin_rate,
      this.coin_available,
        this. decimalval,
        this. select,
      this.showmore});
}
class Collectibles{


  String? img;
  String? coin_name;
  String? coin_cost;
  String? coin_qty;
  String? coin_rate;
  String? coin_available;
  bool? showmore;

 Collectibles(
      {this.img,
      this.coin_name,
      this.coin_cost,
      this.coin_qty,
      this.coin_rate,
      this.coin_available,
      this.showmore});
}class Transactions{


  String?  name;
  String?  send;
  String? hash;
  String? from;
  String? to;
  String? date;
  String? amount;
  String? transactiontype;
  String? fee;
  String? result;


  Transactions(
      {this.name,
        this.send,
      this.hash,
      this.from,
      this.to,
      this.date,
      this.amount,
      this.transactiontype,
      this.fee,
      this.result});
}
class NetworkSetting{



  String? title;
  String? subtitle;
  bool? check;


  NetworkSetting(
      {
      this.title,
      this.subtitle,
      this.check});
}class Recommandation{



  String? title;
  String? subtitle;
  String? img;


  Recommandation(
      {
      this.title,
      this.subtitle,
      this.img});
}
class BackupHistory {
  String? accname;
  String? address;
  String? time;
  BackupHistory({
    this.accname,
    this.address,
    this.time,
  });

  BackupHistory.fromMap(Map map)        // This Function helps to convert our Map into our User Object
      : this.accname = map["accname"],
        this.address = map["address"],
        this.time = map["time"];

  Map toMap() {               // This Function helps to convert our User Object into a Map.
    return {
      "accname": this.accname,
      "address": this.address,
      "time": this.time,
    };
  }
}