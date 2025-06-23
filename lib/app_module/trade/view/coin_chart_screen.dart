
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wealth_wise/app_module/buy_sell/view/sell_screen.dart';
import 'package:wealth_wise/app_module/trade/controller/coin_controller.dart';
import 'package:wealth_wise/app_module/trade/model/coin_model.dart';
import '../../../utils/app_color/app_color.dart';
import '../../../utils/fonts/app_fonts.dart';
import '../../../widegts/app_button/custum_button.dart';
import '../../../widegts/app_text/textwidget.dart';
import '../../bottom_navigation/navigation_screen.dart';
import '../../buy_sell/controller/buy_coin_controller.dart';
import '../../buy_sell/view/buy_screen.dart';
import '../../portfolio/view/withdraw_screen.dart';
import '../widget/candel_stick.dart';
class CoinChartScreen extends StatefulWidget {
  final String coinId;
  final String uid;
  final double userBalance;
  CoinModel coin;

  CoinChartScreen({required this.coinId, required this.coin,required this.uid , required this.userBalance});

  @override
  State<CoinChartScreen> createState() => _CoinChartScreenState();
}

class _CoinChartScreenState extends State<CoinChartScreen> {
  CoinController controller = Get.find();
  String selectedTime = "7";

  final List<Map<String, String>> timeOptions = [
    // {"label": "1H", "days": "0.04"},
    {"label": "1D", "days": "1"},
    {"label": "1W", "days": "7"},
    {"label": "1M", "days": "30"},
    {"label": "6M", "days": "180"},
    {"label": "1Y", "days": "365"},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchChartData(widget.coinId, selectedTime);
    });
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: ()=> Get.back(), icon: Icon(Icons.arrow_back_ios_new)),

                Row(
                  children: [

                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.coin.image ?? ""),
                      radius: 18,
                    ),
                    SizedBox(width: 12),
                    Text(
                      widget.coin.name ?? "No name",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "(${widget.coin.symbol?.toUpperCase()})" ?? "",
                      style: TextStyle(color: Colors.grey[600],fontSize: 14,),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "\$${widget.coin.currentPrice?.toStringAsFixed(2) ?? '--'}",
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.jetBlack,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(

                      "${widget.coin.priceChange24h?.toStringAsFixed(2) ?? '--'} (${widget.coin.priceChangePercentage24h?.toStringAsFixed(2) ?? '--'}%)",
                      style: TextStyle(
                        fontSize: 18,
                        color: (widget.coin.priceChangePercentage24h ?? 0) < 0 ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          SizedBox(height: 20),
         Obx((){
             if (controller.isLoading.value) {
               return Center(child: CircularProgressIndicator());
             }

             if (controller.candleData.isEmpty) {
               return Center(child: Text("No data"));
             }
           //return  buildCandleChart(controller.candleData);
           return  SingleChildScrollView(
             scrollDirection: Axis.horizontal,
             child: SizedBox(
               width: 800, // wider chart
               child: buildCandleChart(controller.candleData),
             ),
           )
           ;

         }),

          SizedBox(height: 20),
          Divider(),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: timeOptions.map((option) {
                final isSelected = selectedTime == option['days'];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedTime = option['days']!;
                      });
                      controller.fetchChartData(widget.coinId, option['days']!);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.lightBlue[50] : Colors.white,
                      foregroundColor: Colors.blue,
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // more radius for round look
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    ),
                    child: Text(
                      option['label']!,
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),



          Container(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.coin.image ?? ""),
                  radius: 18,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.coin.name ?? "No name",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.coin.symbol?.toUpperCase() ?? "",
                        style: TextStyle(color: Colors.grey[600]),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),



                SizedBox(width: Get.width*0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${widget.coin.currentPrice?.toStringAsFixed(2) ?? '--'}",
                      style: TextStyle(
                        color: AppColors.jetBlack,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${widget.coin.priceChangePercentage24h?.toStringAsFixed(2) ?? '--'}%",
                      style: TextStyle(
                        color: (widget.coin.priceChangePercentage24h ?? 0) < 0 ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            height: Get.height*0.067,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: ()=>    Get.to(()=> WithdrawScreen(uid: FirebaseAuth.instance.currentUser!.uid,)),
              child: Row(
              children: [
                Expanded(child:   TextWidget(
                  text: "Transactions",
                  fSize: 15,
                  fWeight: FontWeights.medium,
                  textColor: AppColors.jetBlack,
                ),),

                Icon(Icons.arrow_forward_ios)
              ],
              ),
            ),
          ),
SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomElevatedButton(
                text: "BUY",
                backgroundColor: AppColors.successGreen,
                textColor: Colors.white,
                width: Get.width * 0.4,

                fontSize: 13.sp,
                borderRadius: 7,
                fontWeight: FontWeights.semiBold,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BuyCoinScreen(
                        coin: widget.coin,
                        uid: widget.uid,
                        userBalance: widget.userBalance.toDouble(), // get from Firestore
                      ),
                    ),
                  );

                },
              ),
              CustomElevatedButton(
                text: "SELL",
                backgroundColor: AppColors.dangerRed,
                textColor: Colors.white,
                width: Get.width * 0.4,

                fontSize: 13.sp,
                borderRadius: 7,
                fontWeight: FontWeights.semiBold,
                onPressed: () {
                  final BuyCoinController _buyCoinController = Get.put(BuyCoinController());

                  _buyCoinController.coinsAmount(coinId: widget.coin.id!, uid: widget.uid);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SellCoinScreen(
                        coin: widget.coin,
                        uid: widget.uid,
                        userBalance: widget.userBalance.toDouble(), // get from Firestore
                      ),
                    ),
                  );

                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
