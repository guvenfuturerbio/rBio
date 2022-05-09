// To parse this JSON data, do
//
//     final consentForm = consentFormFromJson(jsonString);

import 'dart:convert';

ConsentForm consentFormFromJson(String str) => ConsentForm.fromJson(json.decode(str));

String consentFormToJson(ConsentForm data) => json.encode(data.toJson());

class ConsentForm {
    ConsentForm({
        this.consentVersion,
        this.consentHeader,
        this.consentContent,
        this.isDeleted,
        this.id,
    });

    String? consentVersion;
    String? consentHeader;
    String? consentContent;
    bool? isDeleted;
    int? id;

    factory ConsentForm.fromJson(Map<String, dynamic> json) => ConsentForm(
        consentVersion: json["consentVersion"],
        consentHeader: json["consentHeader"],
        consentContent: json["consentContent"],
        isDeleted: json["is_deleted"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "consentVersion": consentVersion,
        "consentHeader": consentHeader,
        "consentContent": consentContent,
        "is_deleted": isDeleted,
        "id": id,
    };
}
