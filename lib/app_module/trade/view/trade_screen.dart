import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wealth_wise/app_module/bottom_navigation/navigation_screen.dart';
import 'package:wealth_wise/app_module/trade/view/coin_chart_screen.dart';
import 'package:wealth_wise/widegts/app_button/custum_button.dart';
import 'package:wealth_wise/widegts/custom_size_box_widget/custom_sized_box.dart';
import '../../../utils/app_color/app_color.dart';
import '../../../utils/fonts/app_fonts.dart';
import '../../../widegts/app_text/textwidget.dart';
import '../../../widegts/loader/app_loader.dart';
import '../widget/trade_functions.dart';
import '../controller/coin_controller.dart';

class TradeScreen extends StatelessWidget {
   TradeScreen({super.key});
   CoinController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: ()async{
            await controller.fetchCoins();
          },
          child: SingleChildScrollView(

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.primaryAppBar,
                      borderRadius: BorderRadius.circular(15)

                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      //  3.sbh,
                      Obx((){
                        return TextWidget(
                          text: "Welcome ${controller.userName},",
                          fSize: 18,
                          align: TextAlign.center,
                          fWeight: FontWeights.semiBold,
                          textColor: AppColors.white,
                        );
                      }),
                        7.sbh,
                        TextWidget(
                          text: "Make your first Investment today",
                          fSize: 15,
                          fWeight: FontWeights.medium,
                          textColor: AppColors.white,
                        ),
                        10.sbh,
                        CustomElevatedButton(
                          text: "Invest Today",
                          backgroundColor: AppColors.white,
                          textColor: Colors.blue,
                          width: Get.width * 0.35,

                          fontSize: 13.sp,
                          borderRadius: 7,
                          fontWeight: FontWeights.semiBold,
                          onPressed: () {

                            Get.find<NavigationController>().changeTab(0);

                          },
                        ),



                      ],
                    ),
                  ),
                  15.sbh,
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextWidget(
                      text: "Trending Assets",
                      fSize: 20,
                      fWeight: FontWeights.bold,
                      textColor: AppColors.jetBlack,
                    ),
                  ),
                  15.sbh,
                  Obx(() {
                    if(controller.isLoading.isTrue){
                      return Center(child: customLoader(AppColors.primaryAppBar),);
                    }
                    return ListView.builder(

                      shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     // physics: AlwaysScrollableScrollPhysics(),
                      itemCount: controller.coinList.length,
                      itemBuilder: (context, index) {
                        final coin = controller.coinList[index];
                        String coinId = coin.id.toString();

                        List<double> trend = [
                          (coin.currentPrice ?? 0) - 50,
                          (coin.currentPrice ?? 0) - 1,
                          (coin.currentPrice ?? 0),
                          (coin.currentPrice ?? 0) + 70,
                          (coin.currentPrice ?? 0) + 20,
                        ];

                        bool isLoss = (coin.priceChangePercentage24h ?? 0) < 0;
                        return GestureDetector(
                          onTap: () async{
                         //   double amount = controller.userBalance.value;
                           await controller.fetchUserName();
                            Get.to(()=> CoinChartScreen(coinId: coinId,coin: coin, uid: controller.uid.value, userBalance: controller.userBalance.value,));
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
                                  backgroundImage: NetworkImage(coin.image ?? ""),
                                  radius: 18,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        coin.name ?? "No name",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        coin.symbol?.toUpperCase() ?? "",
                                        style: TextStyle(color: Colors.grey[600]),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),


                                buildSparkline(trend, isLoss),
                                SizedBox(width: Get.width*0.05),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "\$${coin.currentPrice?.toStringAsFixed(2) ?? '--'}",
                                      style: TextStyle(
                                        color: AppColors.jetBlack,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      "${coin.priceChangePercentage24h?.toStringAsFixed(2) ?? '--'}%",
                                      style: TextStyle(
                                        color: isLoss ? Colors.red : Colors.green,
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
                    );
                  }),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}