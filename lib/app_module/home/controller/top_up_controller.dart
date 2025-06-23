import 'package:cloud_firestore/cloud_firestore.dart';  // if using Firestore
import 'package:get/get.dart';
import 'dart:async';

class TopUpController extends GetxController {
  Timer? _timer;
  final userData;
  TopUpController(this.userData);
  RxBool isLoading = false.obs;
  RxString amount = ''.obs;
  RxBool canTopUp = true.obs;
  Rx<Duration> remainingTime = Duration(minutes: 5).obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

  @override
  void onInit() {
    super.onInit();
    _checkTopUpEligibility();
  }

  void _checkTopUpEligibility() {
    final lastTopUp = userData['lastTopUp'];
    if (lastTopUp == null) {
      canTopUp.value = true;
      return;
    }

    DateTime last = DateTime.parse(lastTopUp);
    final now = DateTime.now();
    final diff = now.difference(last);

    if (diff.inHours >= 24) {
      canTopUp.value = true;
    } else {
      canTopUp.value = false;
      remainingTime.value = Duration(hours: 24) - diff;
      _startCountdown();
    }
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value.inSeconds <= 1) {
        timer.cancel();
        canTopUp.value = true;
        remainingTime.value = Duration.zero;
      } else {
        remainingTime.value = remainingTime.value - Duration(seconds: 1);
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> performTopUp() async {
    if (amount.value.isEmpty || double.tryParse(amount.value) == null) {
      throw Exception('Invalid top-up amount');
    }

    try {
      isLoading.value = true;

      // Simulate delay or perform actual backend update
      final String uid = userData['uid'];
      final preBalance = (userData['topUpAmount'] as num).toDouble();

      final userDocRef = _firestore.collection('users').doc(uid);
      await userDocRef.update({
        'topUpAmount': double.parse(amount.value)+ preBalance,
        'lastTopUp': DateTime.now().toIso8601String(),
      });

      canTopUp.value = false;
      remainingTime.value = Duration(hours: 24);
      _startCountdown();

      amount.value = '';
    } catch (e) {
      print('Error updating top-up: $e');
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
