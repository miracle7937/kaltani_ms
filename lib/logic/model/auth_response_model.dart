class AuthResponse {
  bool? status;
  String? message;
  User? user;
  String? token;
  bool? expiresIn;
  String? role;

  AuthResponse(
      {this.status,
      this.message,
      this.user,
      this.token,
      this.expiresIn,
      this.role});

  AuthResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    expiresIn = json['expiresIn'];
    role = json['role'];
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
  String? emailVerifiedAt;
  UserRole? role;
  String? factoryId;
  String? deviceId;
  Location? location;

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
      this.location});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    locationId = json['location_id'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'] != null ? UserRole.fromJson(json['role']) : null;
    factoryId = json['factory_id'];
    deviceId = json['device_id'];

    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
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
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Location {
  int? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? userId;

  Location(
      {this.id, this.name, this.address, this.city, this.state, this.userId});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['user_id'] = userId;
    return data;
  }
}

class UserRole {
  String? name;

  UserRole({this.name});

  UserRole.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}
