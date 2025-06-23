import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wealth_wise/app_module/consultant/consultant_list_screen.dart';
import 'package:wealth_wise/utils/app_color/app_color.dart';
import 'package:wealth_wise/widegts/app_text/app_text.dart';

class ConsultantDetailScreen extends StatelessWidget {
  final Consultant consultant;
   ConsultantDetailScreen({super.key,required this.consultant});

    void _launchWhatsApp() async {

    String phoneNumber = "923174689617"; // Replace with your number
    String message = Uri.encodeComponent("wealth Wise! How i can help yoy ");
    _launchUrl("https://wa.me/$phoneNumber?text=$message");
  }
  void _launchUrl(String mail) async {
    if (!await launchUrl(Uri.parse(mail))) throw 'Could not launch $mail';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding:  const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          IconButton(onPressed: ()=> Get.back(), icon: Icon(Icons.arrow_back_ios_new)),

          AppText(text: 'Consultant Profile',size: 24,fontWeight: FontWeight.bold),
          SizedBox(height: 12),

        Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primaryAppBar,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Icon(Icons.person, size: 48, color: Colors.blue),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                  color: Colors.transparent, // optional background color
                ),
                child: Center(
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
              ),

              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(consultant.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Text(consultant.type,
                        style: TextStyle(color: Colors.white,)),
                    Row(
                      children: List.generate(
                        consultant.rating.floor(),
                            (i) => Icon(Icons.star,
                            color: Colors.orange, size: 16),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  _launchUrl('mailto:contactwealthwiseapp@gmail.com');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                child: Text('Chat Now'),
              )
            ],
          ),
        ),
          SizedBox(height: 12),
          Expanded(
            child: Container(
             
              width: Get.width,
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryAppBar,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: "About Consultant",size: 24,fontWeight: FontWeight.bold,color: Colors.white),
                  SizedBox(height: 08),
                  AppText(text: consultant.about,size: 18,fontWeight: FontWeight.w400,color:Colors.white),
                  SizedBox(height: 15),
                  AppText(text: "Available Slot",size: 24,fontWeight: FontWeight.bold,color: Colors.white),
                  SizedBox(height: 08),
                  AppText(text: consultant.availableSlots,size: 18,fontWeight: FontWeight.w400,color:Colors.white),
                Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _launchWhatsApp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: Text('Chat Now'),
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _launchUrl('mailto:contactwealthwiseapp@gmail.com');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: Text('Book a Session'),
                    ),
                  ),

                ],
            
              ),
            ),
          )
        ],
      )
        ,),
    );
  }
}
