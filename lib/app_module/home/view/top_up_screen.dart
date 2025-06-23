import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wealth_wise/utils/app_color/app_color.dart';
import '../controller/top_up_controller.dart';

class TopUpScreen extends StatelessWidget {
  final userData;
  TopUpScreen({required this.userData});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TopUpController(userData));

    // Keyboard button builder
    Widget numButton(String value) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => controller.amount.value += value,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              alignment: Alignment.center,
              child: Text(
                value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      );
    }

    Widget iconButton(IconData icon, VoidCallback onTap) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 28, color: Colors.red),
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {

        return !controller.isLoading.value;
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          centerTitle: false
          ,
          backgroundColor: AppColors.primaryAppBar,
          title:Text(
            "Top-up Balance",
      
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ) ,
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40),
              Obx(() => AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: controller.canTopUp.value
                    ? Text(
                  "Top-up available",
                  key: ValueKey("available"),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryAppBar),
                )
                    : Text(
                  "Next top-up in:\n${controller.remainingTime.value.toString().split('.').first}",
                  key: ValueKey("wait"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              )),
              SizedBox(height: 70),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                margin: EdgeInsets.symmetric(horizontal: 60),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Obx(() => Text(
                  controller.amount.value.isEmpty
                      ? "\$0.00"
                      : "\$${controller.amount.value}",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                )),
              ),
              SizedBox(height: 7),
              Text(
               "YOU CAN HIT MAX 1000\$ PER DAY",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 1 2 3
                    Row(
                      children: [
                        numButton("1"),
                        numButton("2"),
                        numButton("3"),
                      ],
                    ),
                    // 4 5 6
                    Row(
                      children: [
                        numButton("4"),
                        numButton("5"),
                        numButton("6"),
                      ],
                    ),
                    // 7 8 9
                    Row(
                      children: [
                        numButton("7"),
                        numButton("8"),
                        numButton("9"),
                      ],
                    ),
                    // empty 0 backspace
                    Row(
                      children: [
                        Expanded(child: SizedBox()), // empty space
                        numButton("0"),
                        iconButton(Icons.backspace, () {
                          if (controller.amount.value.isNotEmpty) {
                            controller.amount.value = controller.amount.value
                                .substring(0, controller.amount.value.length - 1);
                          }
                        }),
                      ],
                    ),
                    SizedBox(height: 20),
                    Obx(() => SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: controller.canTopUp.value && !controller.isLoading.value
                            ? () async {
                          try {
                            final enteredAmount = double.tryParse(controller.amount.value);
                            if (enteredAmount == null || enteredAmount <= 0) {
                              Get.snackbar('Invalid amount', 'Please enter a valid amount.');
                              return;
                            }
                            if (enteredAmount > 1000) {
                              Get.snackbar('Limit exceeded', 'Amount must be 1000 or less.');
                              return;
                            }

                            await controller.performTopUp();
                            Get.snackbar('Success', 'Top-up completed!');
                            Get.back();
                          } catch (e) {
                            Get.snackbar('Error', e.toString());
                          }
                        }
                            : null,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.canTopUp.value && !controller.isLoading.value
                              ? AppColors.primaryAppBar
                              : Colors.grey.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : Text(
                          "Confirm Top-Up",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
