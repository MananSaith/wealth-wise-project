import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:wealth_wise/app_module/bottom_navigation/navigation_screen.dart';
import '../../portfolio/view/withdraw_screen.dart';
import '../../trade/model/coin_model.dart';

class BuyCoinController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  RxDouble coinAmountSell = 0.0.obs;
  Future<void> buyCoin({
    required String uid,
    required CoinModel coin,
    required double buyAmountBTC,
    required double userBalanceUSD,
  }) async
  {
    print("uid -->> $uid   buyAmountBTC -->> $buyAmountBTC   userBalanceUSD --->> $userBalanceUSD");
    try {
      isLoading(true);
      DocumentReference userDoc = _firestore.collection('users').doc(uid);
      DocumentSnapshot userSnapshot = await userDoc.get();

      double coinBuyPrice = coin.currentPrice ?? 0.0;
      double totalBuyPriceUSD = coinBuyPrice * buyAmountBTC;

      if (totalBuyPriceUSD > userBalanceUSD) {
        Get.snackbar("Error", "Insufficient Balance");
        isLoading(false);
        return;
      }

      double newBalance = userBalanceUSD - totalBuyPriceUSD;
      List<dynamic> updatedPortfolio = [];
      bool coinExists = false;

      if (userSnapshot.exists && userSnapshot['portfolio'] != null) {
        updatedPortfolio = List<Map<String, dynamic>>.from(userSnapshot['portfolio']);
      }

      for (var item in updatedPortfolio) {
        if (item['coin_id'] == coin.id) {
          double oldAmount = (item['amount'] as num).toDouble();
          double oldInvestment = (item['investment'] as num).toDouble();

          double totalAmount = oldAmount + buyAmountBTC;
          double newInvestment = oldInvestment + totalBuyPriceUSD;
          double newAvgPrice = newInvestment / totalAmount;

          item['amount'] = totalAmount;
          item['investment'] = newInvestment;
          item['avg_price'] = newAvgPrice;

          coinExists = true;
          break;
        }
      }

      if (!coinExists) {
        updatedPortfolio.add({
          "coin_id": coin.id,
          "amount": buyAmountBTC,
          "investment": totalBuyPriceUSD,
          "avg_price": coinBuyPrice,
        });
      }

      await userDoc.update({
        "portfolio": updatedPortfolio,
        "topUpAmount": newBalance,
      });

      Get.snackbar("Success", "${coin.name} purchased!");
      isLoading(false);
      Get.find<NavigationController>().changeTab(0);


    } catch (e) {
      isLoading(false);
      print(e.toString());
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> sellCoin({
    required String uid,
    required CoinModel coin,
    required double sellAmountBTC,
    required double userBalanceUSD,
  }) async {
    try {
      isLoading(true);

      DocumentReference userDoc = _firestore.collection('users').doc(uid);
      DocumentSnapshot userSnapshot = await userDoc.get();

      if (!userSnapshot.exists || userSnapshot['portfolio'] == null) {
        Get.snackbar("Error", "${coin.name} not found in portfolio");
        isLoading(false);
        return;
      }

      List<dynamic> portfolio = List<Map<String, dynamic>>.from(userSnapshot['portfolio']);
      double sellPricePerBTC = coin.currentPrice ?? 0.0;
      double totalSellUSD = sellAmountBTC * sellPricePerBTC;
      double newBalance = userBalanceUSD + totalSellUSD;

      bool coinFound = false;

      for (int i = 0; i < portfolio.length; i++) {
        var item = portfolio[i];
        if (item['coin_id'] == coin.id) {
          double currentAmount = (item['amount'] as num).toDouble();
          double currentInvestment = (item['investment'] as num).toDouble();
          double avgPrice = (item['avg_price'] as num).toDouble();

          if (currentAmount < sellAmountBTC) {
            Get.snackbar("Error", "You don't have enough ${coin.name} to sell");
            isLoading(false);
            return;
          }

          double remainingAmount = currentAmount - sellAmountBTC;
          double proportion = sellAmountBTC / currentAmount;
          double deductedInvestment = currentInvestment * proportion;
          double updatedInvestment = currentInvestment - deductedInvestment;

          if (remainingAmount > 0) {
            item['amount'] = remainingAmount;
            item['investment'] = updatedInvestment;
            item['avg_price'] = updatedInvestment / remainingAmount;
            portfolio[i] = item;
          } else {
            portfolio.removeAt(i); // fully sold, remove from portfolio
          }

          coinFound = true;

          // Manually create timestamp
          Timestamp timestamp = Timestamp.now();

          Map<String, dynamic> withdrawEntry = {
            'coin_id': coin.id,
            'coin_name': coin.name,
            'sell_amount_btc': sellAmountBTC,
            'sell_price_per_btc': sellPricePerBTC,
            'total_sell_usd': totalSellUSD,
            'original_avg_price': avgPrice,
            'original_investment': deductedInvestment,
            'profit_or_loss': totalSellUSD - deductedInvestment,
            'timestamp': timestamp,
          };

          final data = userSnapshot.data() as Map<String, dynamic>;
          List<dynamic> withdrawHistory = [];

          if (data.containsKey('withdrawUSDT') && data['withdrawUSDT'] != null) {
            withdrawHistory = List<dynamic>.from(data['withdrawUSDT']);
          }
          withdrawHistory.add(withdrawEntry);

          await userDoc.update({
            'portfolio': portfolio,
            'topUpAmount': newBalance,
            'withdrawUSDT': withdrawHistory,
          });


          Get.snackbar("Success", "${coin.name} sold successfully!");
          isLoading(false);
          Get.to(()=> WithdrawScreen(uid: uid,));
          return;
        }
      }

      if (!coinFound) {
        Get.snackbar("Error", "${coin.name} not found in portfolio");
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      print(e.toString());
      Get.snackbar("Error", e.toString());
    }
  }


  void coinsAmount({required String coinId, required String uid,})async {
    DocumentReference userDoc = _firestore.collection('users').doc(uid);
    DocumentSnapshot userSnapshot = await userDoc.get();

    if (!userSnapshot.exists || userSnapshot['portfolio'] == null) {
      Get.snackbar("Error", "$coinId not found in portfolio");
      isLoading(false);
      return;
    }

    List<dynamic> portfolio = List<Map<String, dynamic>>.from(
        userSnapshot['portfolio']);

    for (var item in portfolio) {
      if (item['coin_id'] == coinId) {
        coinAmountSell.value = (item['amount'] as num).toDouble();
        break;
      }
    }
  }
}
