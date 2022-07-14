/// E-Konsey sayfalarina yer alan bütün kartların super sınıfıdır.
/// Tüm kartların ortak özellikleri olan [title], [diagnosis],
/// [departmentManager] ve [color] özelliklerini içerir.
///
/// İleride eklenecek herhangi bir özellik tüm kartlar için ortak ise bu class'a eklenebilir.
abstract class ICouncilCardModel {
  /// Kart Başlığı
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
    this.color = 0x00000000,
  });
}
