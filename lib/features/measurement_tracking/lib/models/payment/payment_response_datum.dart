class Datum {
  String doResult;

  Datum({this.doResult});

  Datum.fromJson(Map<String, dynamic> json) {
    doResult = json['do_result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['do_result'] = this.doResult;
    return data;
  }
}