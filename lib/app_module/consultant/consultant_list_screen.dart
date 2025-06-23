import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wealth_wise/app_module/consultant/consultant_detail_screen.dart';
import 'package:wealth_wise/utils/app_color/app_color.dart';
import 'package:wealth_wise/widegts/app_text/app_text.dart';

class Consultant {
  final String name;
  final String type;
  final double rating;
  final String about;
  final String availableSlots;

  Consultant({
    required this.name,
    required this.type,
    required this.rating,
    required this.about,
    required this.availableSlots,
  });
}

class ConsultantController extends GetxController {
  TextEditingController searchController = TextEditingController();
  List<Consultant> allConsultants = [
    Consultant(
      name: 'Ali Khan',
      type: 'Financial Advisor',
      rating: 4.5,
      about: 'Expert in personal finance and crypto budgeting. Helps individuals manage their crypto investments and create sustainable financial plans.',
      availableSlots: 'Mon-Fri: 10:00AM - 5:00PM',
    ),
    Consultant(
      name: 'Sara Ahmed',
      type: 'Financial Advisor',
      rating: 3.8,
      about: 'Helps crypto startups and Web3 businesses scale with practical growth strategies and fundraising insights.',
      availableSlots: 'Mon-Fri: 9:00AM - 4:00PM',
    ),
    Consultant(
      name: 'Imran Shah',
      type: 'Financial Advisor',
      rating: 3.2,
      about: 'Specialized in crypto regulation and smart contracts. Offers legal compliance and documentation support.',
      availableSlots: 'Mon-Fri: 11:00AM - 6:00PM',
    ),
    Consultant(
      name: 'Nida Farooq',
      type: 'Financial Advisor',
      rating: 5.6,
      about: 'Experienced in analyzing blockchain networks and helping users understand DeFi, tokens, and gas fees.',
      availableSlots: 'Mon-Fri: 10:00AM - 3:00PM',
    ),
    Consultant(
      name: 'Zeeshan Raza',
      type: 'Financial Advisor',
      rating: 4.7,
      about: 'Full-time crypto trader. Offers guidance on risk management, chart analysis, and market entries.',
      availableSlots: 'Mon-Sat: 12:00PM - 6:00PM',
    ),
    Consultant(
      name: 'Anum Malik',
      type: 'Financial Advisor',
      rating: 2.3,
      about: 'Specialist in NFT strategy, minting, and marketplaces. Helps artists and investors navigate NFT space.',
      availableSlots: 'Tue-Sat: 1:00PM - 5:00PM',
    ),
    Consultant(
      name: 'Faraz Sheikh',
      type: 'Financial Advisor',
      rating: 1.9,
      about: 'Provides technical assistance in smart contract development, DApps, and token launches.',
      availableSlots: 'Mon-Fri: 2:00PM - 7:00PM',
    ),
    Consultant(
      name: 'Maham Qureshi',
      type: 'Financial Advisor',
      rating: 5.4,
      about: 'Builds diversified crypto portfolios for long-term holding and passive income generation.',
      availableSlots: 'Mon-Fri: 11:00AM - 4:00PM',
    ),
    Consultant(
      name: 'Omar Nawaz',
      type: 'Financial Advisor',
      rating: 4.5,
      about: 'Helps users secure wallets, avoid scams, and implement best practices for crypto safety.',
      availableSlots: 'Mon-Fri: 10:00AM - 6:00PM',
    ),
    Consultant(
      name: 'Iqra Javed',
      type: 'Financial Advisor',
      rating: 4.6,
      about: 'Advises projects on token utility, distribution, and economic models for sustainable growth.',
      availableSlots: 'Mon-Thu: 12:00PM - 5:00PM',
    ),
    Consultant(
      name: 'Bilal Yousuf',
      type: 'Financial Advisor',
      rating: 4.7,
      about: 'Guides users on using decentralized finance apps like lending platforms, liquidity pools, and yield farming.',
      availableSlots: 'Tue-Sat: 10:00AM - 5:00PM',
    ),
    Consultant(
      name: 'Rida Khan',
      type: 'Financial Advisor',
      rating: 4.3,
      about: 'Helps with tax filing, profit/loss reports, and crypto-related legal documentation.',
      availableSlots: 'Mon-Fri: 9:00AM - 3:00PM',
    ),
  ];


  RxList<Consultant> filteredConsultants = <Consultant>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredConsultants.value = allConsultants;
    searchController.addListener(filterConsultants);
  }

  void clearSearch() {
    searchController.clear();
    filterConsultants(); // refresh list
  }

  void filterConsultants() {
    String query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredConsultants.value = allConsultants;
    } else {
      filteredConsultants.value = allConsultants
          .where((consultant) =>
          consultant.name.toLowerCase().contains(query))
          .toList();
    }
  }
}

class ConsultantScreen extends StatelessWidget {
  final ConsultantController controller = Get.put(ConsultantController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            AppText(text: 'Chat with consultant now',size: 24,fontWeight: FontWeight.bold),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    decoration: InputDecoration(
                      hintText: 'Search consultant',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: controller.clearSearch,
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.blue),
                  ),
                )
              ],
            ),


            // List of consultants
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.filteredConsultants.length,
                  itemBuilder: (context, index) {
                    final consultant = controller.filteredConsultants[index];
                    return Container(
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
                              Get.to(()=> ConsultantDetailScreen(consultant: consultant,));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                            ),
                            child: Text('Chat Now'),
                          )
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
