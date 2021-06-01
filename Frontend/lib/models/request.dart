class Inspection {
  bool vehicleVisit;
  String date;
  String inquiry;

  Inspection(
      {this.vehicleVisit,

      // this.username,
      // this.email,
      this.inquiry,
      this.date});
  // factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
  Map<String, dynamic> toJson() => _$ModelToJson(this);

  _$ModelToJson(Inspection instance) => <String, dynamic>{
        'vehicleVisit': instance.vehicleVisit,
        'date': instance.date,
        'inquiry': instance.inquiry,
      };
}
