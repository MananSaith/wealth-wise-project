import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_color/app_color.dart';
import '../../trade/model/coin_model.dart';
import '../controller/buy_coin_controller.dart';

class BuyCoinScreen extends StatefulWidget {
  final CoinModel coin;
  final String uid;
  final double userBalance;

  const BuyCoinScreen({
    Key? key,
    required this.coin,
    required this.uid,
    required this.userBalance,
  }) : super(key: key);

  @override
  State<BuyCoinScreen> createState() => _BuyCoinScreenState();
}

class _BuyCoinScreenState extends State<BuyCoinScreen> {
  String inputAmount = '';
  final BuyCoinController _buyCoinController = Get.put(BuyCoinController());

  double get currentPrice => widget.coin.currentPrice ?? 0;

  double get totalUSD {
    double btcAmount = double.tryParse(inputAmount) ?? 0;
    return btcAmount * currentPrice;
  }

  void _onKeyPress(String value) {
    setState(() {
      if (value == 'DEL') {
        if (inputAmount.isNotEmpty) {
          inputAmount = inputAmount.substring(0, inputAmount.length - 1);
        }
      } else {
        if (value == '.' && inputAmount.contains('.')) return;
        inputAmount += value;
      }
    });
  }

  Widget buildKey(String value) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onKeyPress(value),
        child: Container(
          margin: EdgeInsets.all(4),
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
           // color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 40),
            // Coin Info
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.coin.image ?? ''),
                  radius: 30,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Row(
                     children: [
                       Text("Buy ${widget.coin.name}" ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                       Text("(${widget.coin.symbol?.toUpperCase()})" ?? '', style: TextStyle(color: Colors.grey)),
                     ],
                   ),
                    Text("\$${currentPrice.toStringAsFixed(2)}", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),

            // Entered Amount
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              alignment: Alignment.center,
              child: Text(
                inputAmount.isEmpty ? "0.0 ${widget.coin.symbol?.toUpperCase()}" : "$inputAmount ${widget.coin.symbol?.toUpperCase()}",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),

            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total in USD:"),
                Text("\$${totalUSD.toStringAsFixed(2)}"),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Available USD:"),
                Text("\$${widget.userBalance.toStringAsFixed(2)}"),
              ],
            ),
            SizedBox(height: 20),

            // Custom Keyboard
            Column(
              children: [
                Row(children: [buildKey("1"), buildKey("2"), buildKey("3")]),
                Row(children: [buildKey("4"), buildKey("5"), buildKey("6")]),
                Row(children: [buildKey("7"), buildKey("8"), buildKey("9")]),
                Row(children: [buildKey("."), buildKey("0"), buildKey("DEL")]),
              ],
            ),
            SizedBox(height: 20),

            // Buy Button
           Obx(()=> ElevatedButton(
             onPressed: () {
               double amount = double.tryParse(inputAmount) ?? 0;
               if (amount <= 0) {
                 Get.snackbar("Invalid", "Enter a valid amount");
                 return;
               }else if(_buyCoinController.isLoading.isTrue){
                 return ;
               }

               _buyCoinController.buyCoin(
                 uid: widget.uid,
                 coin: widget.coin,
                 buyAmountBTC: amount.toDouble(),
                 userBalanceUSD: widget.userBalance.toDouble(),
               );
             },


             style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50),backgroundColor:_buyCoinController.isLoading.isTrue? Colors.grey: Colors.green),
             child: Text("Preview Buy" ,style: TextStyle(color: Colors.white),),
           ),)
          ],
        ),
      ),
    );
  }
}
