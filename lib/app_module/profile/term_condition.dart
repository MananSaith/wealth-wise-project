import 'package:flutter/material.dart';
import 'package:wealth_wise/utils/app_color/app_color.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryAppBar,
        title: const Text("Terms & Conditions",style: TextStyle(color: AppColors.white),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,color: AppColors.white,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome to WealthWise!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "By using our app, you agree to the following terms and conditions. Please read them carefully before proceeding.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),

                    Text(
                      "1. Financial Disclaimer",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "- WealthWise does not offer financial or investment advice.\n"
                          "- All charts, data, and market signals are for informational purposes only.\n"
                          "- Always consult a professional before making any financial decisions.",
                    ),
                    SizedBox(height: 16),

                    Text(
                      "2. Market Risks",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "- Crypto markets are volatile and carry risk.\n"
                          "- You are solely responsible for your trading or investment actions.\n"
                          "- WealthWise will not be liable for any losses incurred.",
                    ),
                    SizedBox(height: 16),

                    Text(
                      "3. Account and Data",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "- You must provide accurate account information.\n"
                          "- Your portfolio and preferences are stored securely.\n"
                          "- We do not share personal data with third parties without consent.",
                    ),
                    SizedBox(height: 16),

                    Text(
                      "4. API and Third-Party Services",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "- We use third-party APIs (e.g., CoinGecko) to fetch market data.\n"
                          "- We are not responsible for any inaccuracies or downtimes in their services.",
                    ),
                    SizedBox(height: 16),

                    Text(
                      "5. Usage Rules",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "- Do not misuse the app or attempt to reverse engineer it.\n"
                          "- Any abuse or suspicious activity may lead to account termination.",
                    ),
                    SizedBox(height: 16),

                    Text(
                      "6. Updates & Changes",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "- We may update these terms from time to time.\n"
                          "- Continuing to use WealthWise means you accept the updated terms.",
                    ),
                    SizedBox(height: 24),

                    Text(
                      "If you do not agree with any part of these terms, please do not use WealthWise.",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
