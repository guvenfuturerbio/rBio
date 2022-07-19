
import '../e_council_inspection_upload/model/council_inspections_upload_model.dart';

const String whatIsTheECouncil =
    """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to""";
const String howToUseTheECouncil =
    """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to""";

const List<String> listOfSearchItems = [
  'Nöro gelişimsel bozukluk',
  'Depresif bozukluklar',
  'Bel Ağrısı',
  'Disosiyatif bozukluklar',
  'Beslenme ve yeme bozuklukları',
];

List<String> silRecordList = [
  'Ses dosyasi 1',
  'Ses dosyasi 2',
  'Ses dosyasi 3',
];

List<String> silFileList = [
  'Dosya adi - aciklamasi',
  'Dosya adi - aciklamasi',
  'Dosya adi - aciklamasi',
  'Dosya adi - aciklamasi',
  'Dosya adi - aciklamasi',
];

List<CouncilInspectionUploadModel> requestedInspections = [
  const CouncilInspectionUploadModel(inspectionName: 'Beyin Tomografisi', isUploaded: false),
  const CouncilInspectionUploadModel(inspectionName: 'Göğüs Röntgeni', isUploaded: false),
  const CouncilInspectionUploadModel(inspectionName: 'Alyuvar Testi', isUploaded: false),
];
