class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _address;
  late String _latitude;
  late String _longitude;

  AddressModel(
      {id,
      required addressType,
      contactPersonName,
      contactPersonNumber,
      address,
      latitude,
      longitude}) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = _contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  String get address => _address;
  String? get contactPersonNumber => _contactPersonNumber;
  String? get contactPersonName => _contactPersonName;
  String get addressType => _addressType;
  String get longitude => _longitude;
  String get latitude => _latitude;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'] ?? "";
    _contactPersonNumber = json["_contact_person_number"] ?? "";
    _contactPersonName = json["_contact_person_name"] ?? "";
    _address = json["address"];
    _latitude = json["latitude"];
    _longitude = json["longitude"];
  }


}
