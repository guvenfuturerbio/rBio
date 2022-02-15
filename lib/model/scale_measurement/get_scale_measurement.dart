/// Scale Measurementların api destekli çekilmesini sağlayan model yapısı
/// * sadece [entegration_id]: bütün verileri çeker
/// * [entegration_id] + [begin_date]: başlangıç tarihinden itibaren olan ölçümleri gösterir.
/// * [entegration_id] + [end_date]: bitiş tarihine kadar olan ölçümleri gösterir.
/// * [entegration_id] + [count]: count kadar son ölçümleri getirir.
/// * [entegration_id] + [begin_date] + [end_date]: aralık arasındaki bütün ölçümleri getirir.
/// * [entegration_id] + [begin_date] + [end_date] + count: aralıktaki count ile belirtilen sayıdaki son ölçümleri getirir.
class GetScaleMasurementBody {
  GetScaleMasurementBody({
    this.entegrationId,
    this.beginDate,
    this.endDate,
    this.count,
  });

  int? entegrationId;
  DateTime? beginDate;
  DateTime? endDate;
  int? count;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['entegration_id'] = entegrationId;
    if (beginDate != null) map['begin_date'] = beginDate?.toIso8601String();
    if (endDate != null) map['end_date'] = endDate?.toIso8601String();
    if (count != null) map['count'] = count;

    return map;
  }
}
