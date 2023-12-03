class Device {
  final int? id;
  final String? location;
  final int? employeeId;
  final int? priority;
  final bool? has;

  Device({this.id, this.location, this.employeeId, this.priority, this.has});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['Device_ID'],
      location: json['Device_Location'],
      employeeId: json['User_Employee_ID'],
      priority: json['Priority'],
      has: json['has'] != null ? json['has'] != 0 : null,
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      "Device_ID": id,
      "Device_Location": location,
      "User_Employee_ID": employeeId,
    };
  }
}
