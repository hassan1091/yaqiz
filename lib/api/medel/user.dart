class User {
  final int? employeeID;
  final String? employeeEmail;
  final String? employeePassword;
  final int? employeePhone;
  final bool isAdmin;

  User({
    this.employeeID,
    this.employeeEmail,
    this.employeePassword,
    this.employeePhone,
    this.isAdmin = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      employeeID: json['Employee_ID'],
      employeeEmail: json['Employee_Email'],
      employeePassword: json['Employee_Password'],
      employeePhone: json['Employee_Phone'],
      isAdmin: json['isAdmin'] != 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Employee_Email': employeeEmail,
      'Employee_Password': employeePassword,
      'Employee_Phone': employeePhone,
      'isAdmin': isAdmin ? 1 : 0,
    };
  }
}
