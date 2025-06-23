import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wealth_wise/app_module/bottom_navigation/navigation_screen.dart';
import 'package:wealth_wise/app_module/home/controller/home_controller.dart';
import 'package:wealth_wise/app_module/portfolio/view/withdraw_screen.dart';
import 'package:wealth_wise/app_module/trade/controller/coin_controller.dart';
import 'package:wealth_wise/app_module/trade/widget/trade_functions.dart';
import 'package:wealth_wise/utils/fonts/app_fonts.dart';
import 'package:wealth_wise/widegts/app_text/textwidget.dart';
import 'package:wealth_wise/widegts/custom_size_box_widget/custom_sized_box.dart';
import '../../../utils/app_color/app_color.dart';


class PortfolioScreen extends StatelessWidget {
  PortfolioScreen({super.key});

  final controller = Get.put(HomeController());
  final uid = FirebaseAuth.instance.currentUser?.uid;
  CoinController coinController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: uid == null
          ? Center(child: Text("User not logged in"))
          : StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("User data not found"));
          }

          final userData =
          snapshot.data!.data() as Map<String, dynamic>?;

          final List<dynamic> portfolio = userData?['portfolio'] ?? [];

          double invested = 0.0;

          for (int i = 0; i < portfolio.length; i++) {
            var investment = portfolio[i]["investment"];

            invested += double.tryParse(investment.toString()) ?? 0.0;
          }


          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.sbh,
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAppBar,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [



                        TextWidget(
                          text:
                          "Portfolio",
                          fSize: 20,
                          fWeight: FontWeights.semiBold,
                          textColor: AppColors.white,
                        ),
                        10.sbh,
                        TextWidget(
                          text:
                          "Holding value",
                          fSize: 18,
                          fWeight: FontWeights.semiBold,
                          textColor: AppColors.white,
                        ),

                        TextWidget(
                          text:
                          "\$${(userData?['topUpAmount'] + invested )?.toStringAsFixed(2)?? '0.00'}",
                          fSize: 18,
                          fWeight: FontWeights.semiBold,
                          textColor: AppColors.white,
                        ),
                        10.sbh,
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             TextWidget(
                               text:
                               "Invested USD",
                               fSize: 16,
                               fWeight: FontWeights.medium,
                               textColor: AppColors.white,
                             ),
                             TextWidget(
                               text:
                               "\$${invested.toString()}",
                               fSize: 18,
                               fWeight: FontWeights.semiBold,
                               textColor: AppColors.white,
                             ),
                           ],
                         ),
                         20.sbw,
                         SizedBox(
                           height: Get.height*0.05,
                           child: VerticalDivider(
                             thickness: 1,
                             width: 1,
                             color: AppColors.white,
                           ),
                         ),
                         20.sbw,
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             TextWidget(
                               text:
                               "Available USD",
                               fSize: 16,
                               fWeight: FontWeights.medium,
                               textColor: AppColors.white,
                             ),
                             TextWidget(
                               text:
                               "\$${userData?['topUpAmount']?.toStringAsFixed(2) ?? '0.00'}",
                               fSize: 18,
                               fWeight: FontWeights.semiBold,
                               textColor: AppColors.white,
                             ),
                           ],
                         )
                       ],
                     )
                      ],
                    ),
                  ),
                  10.sbh,
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: ()=>Get.find<NavigationController>().changeTab(0)
                          ,
                          child: Container(

                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                          color: AppColors.primaryAppBar,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child:   TextWidget(
                                text:
                                "Deposit USD",
                                fSize: 14,
                                fWeight: FontWeights.semiBold,
                                textColor: AppColors.white,
                              )
                              ,
                            ),
                          ),
                        ),
                      ),
                      20.sbw,
                      Expanded(
                        child: GestureDetector(
                          onTap: ()=> Get.to(()=> WithdrawScreen(uid: uid!,)),
                          child: Container(
                          
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                          
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child:   TextWidget(
                                text:
                                "Withdraw USD",
                                fSize: 14,
                                fWeight: FontWeights.semiBold,
                                textColor: AppColors.bgDark,
                              )
                              ,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  portfolio.isEmpty ? SizedBox.shrink():
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: portfolio.length,
                    itemBuilder: (context, index) {
                      final item = portfolio[index];
                      final coinId = item['coin_id'];
                      final amount = (item['amount'] as num).toDouble();
                      final buyAvg = (item['avg_price'] as num).toDouble();
                      final buyPrice = (item['investment'] as num).toDouble();

                      final matchingCoin = coinController.coinList.firstWhereOrNull(
                            (coin) => coin.id == coinId,
                      );

                      if (matchingCoin == null) {
                        return ListTile(
                          title: Text("Market data not found for $coinId"),
                        );
                      }
                      List<double> trend = [
                        1, 40, -30, 70, -60, 10,
                        40, -30, 70, -60, 1, 40,

                      ];


                      // final profitLoss = (currentPrice - buyPrice) * amount;
                      // final isProfit = profitLoss >= 0;

                      final currentPrice = matchingCoin.currentPrice ?? 0.0;
                      final currentValue = currentPrice * amount;
                      final profitLoss = currentValue - buyPrice;
                      final profitLossPercent = (profitLoss / buyPrice) * 100;
                      final isProfit = profitLoss >= 0;


                      return GestureDetector(
                        onTap: () async{
                        },
                        child: Container(
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
                                backgroundImage: NetworkImage(matchingCoin.image ?? ""),
                                radius: 18,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      matchingCoin.name ?? "No name",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "${ matchingCoin.symbol?.toUpperCase()} $amount"?? "",
                                      style: TextStyle(color: Colors.grey[600]),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),


                              buildSparkline(trend, !isProfit),
                              SizedBox(width: Get.width*0.05),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$${currentPrice.toStringAsFixed(2)?? '--'}",
                                    style: TextStyle(
                                      color: AppColors.jetBlack,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "${profitLoss.toStringAsFixed(2)?? '--'}%",
                                    style: TextStyle(
                                      color: isProfit ? Colors.green : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
