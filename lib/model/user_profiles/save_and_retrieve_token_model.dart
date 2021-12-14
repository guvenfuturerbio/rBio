class SaveAndRetrieveTokenModel {
  String token;
  String accession;

  SaveAndRetrieveTokenModel({
    this.token,
    this.accession,
  });

  factory SaveAndRetrieveTokenModel.fromJson(Map<String, dynamic> json) =>
      SaveAndRetrieveTokenModel(
        token: json['token'] as String,
        accession: json['accession'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'token': token,
        'accession': accession,
      };
}
