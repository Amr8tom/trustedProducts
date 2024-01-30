class Bcodes_model {
  bool? success;
  List<String> ?Bcodes_data;
  List<String> ?manufacture_data;
  List<String> ?pattern_data;

  Bcodes_model({this.manufacture_data,this.Bcodes_data,this.pattern_data});

  Bcodes_model.fromJson(Map<dynamic, dynamic> json) {
    success = json['success'];
    if (json['Bcodes'] != null) {
      Bcodes_data = <String>[];
      json['Bcodes'].forEach((element) {
        Bcodes_data!.add(element);
      });
    }
    if (json['Patterns'] != null) {
      pattern_data = <String>[];
      json['Patterns'].forEach((element) {
        pattern_data!.add(element);
      });
    }
    if (json['manufactures'] != null) {
      manufacture_data = <String>[];
      json['manufactures'].forEach((element) {
        manufacture_data!.add(element);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    if (this.Bcodes_data != null) {
      data['Bcodes'] = this.Bcodes_data;
    }
    if (this.pattern_data != null) {
      data['Patterns'] = this.pattern_data;
    }
    if (this.manufacture_data != null) {
      data['manufactures'] = this.manufacture_data;
    }
    return data;
  }
}
