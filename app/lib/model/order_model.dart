import 'package:app/model/address_model.dart';

class OrderModel {
  late int id;
  late String status;
  late int userId;
  double? orderAmount;
  String? orderStatus;

  String? paymentStatus;
  double? totalTaxAmount;
  String? orderNote;
  String? createdAt;
  String? updatedAt;
  double? deliveryCharge;
  String? scheduleAt;
  String? otp;

  String? refundRequested;
  String? refunded;
  String? scheduled;

  int? detalisCount;

  AddressModel? deliveryAddress;

  OrderModel({
    required this.id,
    required this.userId,
    this.orderAmount,
    this.orderStatus,
    this.paymentStatus,
    this.totalTaxAmount,
    this.orderNote,
    this.createdAt,
    this.updatedAt,
    this.deliveryCharge,
    this.scheduleAt,
    this.otp,
    this.refundRequested,
    this.refunded,
    this.scheduled,
    this.detalisCount,
    this.deliveryAddress,
    this.status = "Accepted",
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderAmount = json['oreder_amount'];
    paymentStatus = json['payment_status'] ?? "pending";
    totalTaxAmount = 10.0;
    orderNote = json['order_note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderStatus = json['oreder_status'];
    deliveryCharge = 10.0;
    scheduleAt = json['shcedule_at'] ?? "";
    otp = json['otp'];

    scheduled = json['scheduled'] ?? "";
    detalisCount = int.parse(json['details_count'] ?? "0");
    status = json['status'];

    deliveryAddress = json['delivery_address'] != null
        ? new AddressModel.fromJson(json['delivery_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['id'] = id;
    json['user_id'] = userId;
    json['oreder_amount'] = orderAmount;
    json['payment_status'] = paymentStatus;

    json['order_note'] = orderNote;
    json['created_at'] = createdAt;
    json['updated_at'] = updatedAt;
    json['oreder_status'] = orderStatus;
    json['shcedule_at'] = scheduleAt;
    json['otp'] = otp;
    json['scheduled'] = scheduled;

    json['details_count'] = detalisCount;
    if (this.deliveryAddress != null)
      json['delivery_address'] = this.deliveryAddress?.toJson();

    return json;
  }
}
