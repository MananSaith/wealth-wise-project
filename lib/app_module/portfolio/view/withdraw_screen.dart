import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wealth_wise/app_module/trade/controller/coin_controller.dart';
import 'package:intl/intl.dart';
import 'package:wealth_wise/utils/app_color/app_color.dart';

class WithdrawScreen extends StatelessWidget {
  final String uid;
  final CoinController coinController = Get.find();

  WithdrawScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryAppBar,
        title: Text('Withdraw History', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final List<dynamic> withdrawList = data['withdrawUSDT'] ?? [];

          if (withdrawList.isEmpty) {
            return Center(child: Text("No withdrawal history found."));
          }

          return ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: withdrawList.length,
            itemBuilder: (context, index) {
              final item = withdrawList[index];
              final coinId = item['coin_id'];
              final matchingCoin = coinController.coinList.firstWhereOrNull(
                    (coin) => coin.id == coinId,
              );

              final profitOrLoss = (item['profit_or_loss'] as num).toDouble();
              final isProfit = profitOrLoss >= 0;

              return Card(
                color: AppColors.primaryAppBar,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 5,
                margin: EdgeInsets.only(bottom: 15),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(matchingCoin?.image ?? ''),
                        radius: 25,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              matchingCoin?.name ?? coinId.toUpperCase(),
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.white),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Sold: ${item['sell_amount_btc']} BTC",
                              style: TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              "Sell Price: \$${item['sell_price_per_btc'].toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 14,color: Colors.white),
                            ),
                            Text(
                              "Total: \$${item['total_sell_usd'].toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 14,color: Colors.white),
                            ),
                            Text(
                              "${isProfit ? 'Profit' : 'Loss'}: \$${profitOrLoss.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: isProfit ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Date: ${_formatTimestamp(item['timestamp'])}",
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp is Timestamp) {
      return DateFormat.yMMMd().add_jm().format(timestamp.toDate());
    }
    return '-';
  }
}
