class Device {
  final int? id;
  final String? location;
  final int? employeeId;

  Device({this.id, this.location, this.employeeId});

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['Device_ID'],
      location: json['Device_Location'],
      employeeId: json['Employee_ID'],
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      "Device_ID": id,
      "Device_Location": location,
      "Employee_ID": employeeId,
    };
  }
}
