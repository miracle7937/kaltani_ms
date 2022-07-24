class AuthResponse {
  bool? status;
  String? message;
  User? user;
  String? token;
  bool? expiresIn;

  AuthResponse(
      {this.status, this.message, this.user, this.token, this.expiresIn});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    expiresIn = json['expiresIn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    data['expiresIn'] = expiresIn;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? locationId;
  Null? emailVerifiedAt;
  String? role;
  Null? factoryId;
  Null? deviceId;
  String? createdAt;
  String? updatedAt;
  Locations? locations;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.email,
      this.locationId,
      this.emailVerifiedAt,
      this.role,
      this.factoryId,
      this.deviceId,
      this.createdAt,
      this.updatedAt,
      this.locations});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    locationId = json['location_id'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    factoryId = json['factory_id'];
    deviceId = json['device_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    locations = json['locations'] != null
        ? Locations.fromJson(json['locations'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['location_id'] = locationId;
    data['email_verified_at'] = emailVerifiedAt;
    data['role'] = role;
    data['factory_id'] = factoryId;
    data['device_id'] = deviceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (locations != null) {
      data['locations'] = locations!.toJson();
    }
    return data;
  }
}

class Locations {
  int? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? userId;
  String? createdAt;
  String? updatedAt;

  Locations(
      {this.id,
      this.name,
      this.address,
      this.city,
      this.state,
      this.userId,
      this.createdAt,
      this.updatedAt});

  Locations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
