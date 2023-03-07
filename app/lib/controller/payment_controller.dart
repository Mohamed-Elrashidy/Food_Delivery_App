import 'package:get/get.dart';

import '../data/repository/payment_repo.dart';

class PaymentController extends GetxController {
  PaymentRepo paymentRepo;
  PaymentController({required this.paymentRepo});

  postOrder(
    String uri, {
    required String firstName,
    required String secondName,
    required String email,
    required String phone,
    required String price,
  }) {
    paymentRepo.postOrder(uri,
        firstName: firstName,
        secondName: secondName,
        email: email,
        phone: phone,
        price: price);
  }
}
