class OrdersDataModel {
  int? id;
  String? orderId;
  String? addedBy;
  String? shopId;
  int? vendorId;
  String? amount;
  String? address;
  String? customerName;
  String? customerPhone;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? packupAddress;
  String? dropAddress;
  String? contactNumber;
  int? deliveryId;
  String? status;
  String? pickup_latitude;
  String? pickup_longitude;
  String? drop_latitude;
  String? drop_longitude;
  bool isLoading = false;

  OrdersDataModel({
    this.id,
    this.orderId,
    this.addedBy,
    this.shopId,
    this.vendorId,
    this.amount,
    this.address,
    this.customerName,
    this.customerPhone,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.packupAddress,
    this.dropAddress,
    this.contactNumber,
    this.deliveryId,
    this.status,
    this.pickup_latitude,
    this.pickup_longitude,
    this.drop_latitude,
    this.drop_longitude,
  });

  OrdersDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'].toString();
    addedBy = json['added_by'].toString();
    shopId = json['shop_id'];
    vendorId = json['vendor_id'];
    amount = json['amount'];
    address = json['address'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    packupAddress = json['packup_address'];
    dropAddress = json['drop_address'];
    contactNumber = json['contact_number'];
    deliveryId = json['delivery_id'];
    status = json['status'];
    pickup_latitude = json['pickup_latitude'];
    pickup_longitude = json['pickup_longitude'];
    drop_latitude = json['drop_latitude'];
    drop_longitude = json['drop_longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['added_by'] = addedBy;
    data['shop_id'] = shopId;
    data['vendor_id'] = vendorId;
    data['amount'] = amount;
    data['address'] = address;
    data['customer_name'] = customerName;
    data['customer_phone'] = customerPhone;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['packup_address'] = packupAddress;
    data['drop_address'] = dropAddress;
    data['contact_number'] = contactNumber;
    data['delivery_id'] = deliveryId;
    data['status'] = status;
    data['pickup_latitude'] = pickup_latitude;
    data['pickup_longitude'] = pickup_longitude;
    data['drop_latitude'] = drop_latitude;
    data['drop_longitude'] = drop_longitude;
    return data;
  }
}
