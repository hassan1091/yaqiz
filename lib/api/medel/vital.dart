class Vital {
  int? vitalId;
  int? hr;
  int? spo2;
  String? bp;
  num? temp;
  int? respiratoryRate;
  int? priority;

  Vital({
    this.vitalId,
    this.hr,
    this.spo2,
    this.bp,
    this.temp,
    this.respiratoryRate,
    this.priority,
  });

  factory Vital.fromJson(Map<String, dynamic> json) {
    return Vital(
      vitalId: json['Vital_ID'],
      hr: json['HR'],
      spo2: json['SPO2'],
      bp: json['BP'],
      temp: json['Temp'],
      respiratoryRate: json['Respiratory_Rate'],
      priority: json['Priority'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Vital_ID': vitalId,
      'HR': hr,
      'SPO2': spo2,
      'BP': bp,
      'Temp': temp,
      'Respiratory_Rate': respiratoryRate,
      'Priority': priority,
    };
  }
}
