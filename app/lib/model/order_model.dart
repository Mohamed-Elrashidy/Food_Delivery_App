import 'package:app/model/address_model.dart';

class OrderModel {
  late int id;
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
  String? pending;
  String? accepted;
  String? confirmed;
  String? processing;
  String? handover;
  String? pickedUp;
  String? delivered;
  String? canceled;
  String? refundRequested;
  String? refunded;
  int? scheduled;
  String? failed;
  int? detalisCount;

  AddressModel? deliveryAddress;

  OrderModel(
      {required this.id,
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
      this.pending,
      this.accepted,
      this.confirmed,
      this.processing,
      this.handover,
      this.pickedUp,
      this.delivered,
      this.canceled,
      this.refundRequested,
      this.refunded,
      this.scheduled,
      this.failed,
      this.detalisCount,
      this.deliveryAddress});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderAmount = json['oreder_amount'].toDouble();
    paymentStatus = json['payment_status'] ?? "pending";
    totalTaxAmount = 10.0;
    orderNote = json['order_note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    orderStatus = json['oreder_status'];
    deliveryCharge = 10.0;
    scheduleAt = json['shcedule_at'] ?? "";
    otp = json['otp'];
    pending = json['pending'] ?? "";
    accepted = json['accepted'] ?? "";
    confirmed = json['confirmed'] ?? "";
    processing = json['processing'] ?? "";
    handover = json['handover'] ?? "";
    pickedUp = json['picked_up'] ?? "";
    delivered = json['delivered'] ?? "";
    canceled = json['cancelled'] ?? "";
    scheduled = json['scheduled'] ?? "";
    failed = json['failed'] ?? "";
    detalisCount = json['details_count'] ?? "";
    deliveryAddress = json['delivery_address'] != null
        ? new AddressModel.fromJson(json['delivery_address'])
        : null;
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> json= <String,dynamic>{};
    json['id']= id ;
    json['user_id']= userId ;
    json['oreder_amount']=orderAmount ;
     json['payment_status']=paymentStatus ;

     json['order_note']=orderNote ;
    json['created_at']= createdAt ;
    json['updated_at']=updatedAt ;
     json['oreder_status']=orderStatus;
    json['shcedule_at'] =scheduleAt ;
    json['otp']=otp ;
    json['pending']= pending ;
     json['accepted'] =accepted ;
   json['confirmed'] = confirmed ;
    json['processing'] =processing ;
    json['handover'] = handover ;
     json['picked_up'] =pickedUp ;
   json['delivered'] =  delivered ;
   json['cancelled'] =  canceled ;
   json['scheduled'] = scheduled ;
     json['failed'] =failed ;
    json['details_count'] = detalisCount ;
    if(this.deliveryAddress!=null)
      json['delivery_address']=this.deliveryAddress?.toJson();

    return json;

  }
}
