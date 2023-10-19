class SteelModel {
  final String fileName;
  final String captureDate;
  final String captureTime;
  final bool isNormal;
  final String defectLabel;
  final String imageAsset;
  final String detectionImageAsset;

  SteelModel(
    this.fileName,
    this.captureDate,
    this.captureTime,
    this.isNormal,
    this.defectLabel,
    this.imageAsset,
    this.detectionImageAsset,
  );
}
