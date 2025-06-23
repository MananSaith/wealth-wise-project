import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import '../model/candle_stick_model.dart';
import '../model/coin_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/detail_model.dart';

class CoinController extends GetxController {
  RxList<CoinModel> coinList = <CoinModel>[].obs;

  List<CandleData> candleData = <CandleData>[].obs;
  RxString userName = ''.obs;
  RxString uid = ''.obs;
  RxDouble userBalance = 0.0.obs;
  RxBool isLoading = true.obs;
   String currentCoinId="";
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUserName();
    fetchCoins();

  }

  Future<void> fetchCoins() async {
    coinList.clear();
    const url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        debugPrint(" $url --->>> $data");

        coinList.value = data.map((e) => CoinModel.fromJson(e)).toList();
        isLoading(false);
      } else {
        print("Failed to fetch coins: ${response.statusCode}");
      }
    } catch (e) {
      print("API Error: $e");
    }
  }



  Future<List<CandleData>> fetchChartDataFromApi(String coinId, String days) async {
    candleData.clear();
    try {
      final url = 'https://api.coingecko.com/api/v3/coins/$coinId/ohlc?vs_currency=usd&days=$days';
      final response = await http.get(Uri.parse(url));

      print("$url   ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> raw = json.decode(response.body);
        debugPrint(" $url --->>> $raw");

        List<CandleData> h = raw.map((e) {
          return CandleData(
            DateTime.fromMillisecondsSinceEpoch(e[0]),
            e[1], e[2], e[3], e[4],
          );
        }).toList();

        return h;
      } else {
        print('Failed to load chart data');
        isLoading.value = false;
        return [];
      }
    } catch (e) {
      print('Error: $e');
      isLoading.value = false;
      return [];
    }
  }




  void fetchChartData(String coinId, String days) async {
    isLoading.value = true;
    currentCoinId = coinId;

    final response = await fetchChartDataFromApi(coinId, days);
    candleData = response;
  //  chartData.value = response;
    isLoading.value = false;
  }
  Future<void> fetchUserName() async {
    print("1111111111111111111111111");
    try {
      final doc = await _firestore.collection('users').doc(_auth.currentUser!.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        userName.value = data['name'] ?? '';
        uid.value = data['uid'] ?? '';
        userBalance.value = data['topUpAmount'] ?? 0;
      } else {
        print("User document not found");
      }
    } catch (e) {
      print("Failed to fetch user name: $e");
    }
  }
}
