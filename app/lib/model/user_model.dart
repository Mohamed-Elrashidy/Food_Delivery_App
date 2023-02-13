class UserModel {
  int id;
  String name;
  String email;
  String phone;
  int orderCount;
  String?image;
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.orderCount,
      });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json["f_name"],
        email: json["email"],
        phone: json["phone"],
        orderCount: json["order_count"],


    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "f_name": this.name,
      "email":this.email,
      "phone":this.phone,
      "order_count":this.orderCount
    };
  }

}
