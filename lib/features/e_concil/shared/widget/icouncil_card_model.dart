// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class ICouncilCardModel {
  /// Card Başlığı
  final String title;

  /// Teşhis
  final String diagnosis;

  /// Bölüm Sorumlusu
  final String departmentManager;

  /// Renk
  final int color;

  const ICouncilCardModel({
    required this.title,
    required this.diagnosis,
    required this.departmentManager,
    required this.color,
  });
}
