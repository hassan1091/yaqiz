class Device {
  final int? id;
  final String? location;
  final int? employeeId;
  final int? priority;

  Device({this.id, this.location, this.employeeId, this.priority});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['Device_ID'],
      location: json['Device_Location'],
      employeeId: json['User_Employee_ID'],
      priority: json['Priority'],
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
