class DroneDimensions {
  final double inputbladelength;
  final double inputdronebodylength;
  final double inputarmwidth;
  final double inputbodywidth;
  late double distancebetweenbladecentres = 0.0;
  late double distancefrombladecentretodronecenter = 0.0;

  DroneDimensions({
    required this.inputbladelength,
    required this.inputdronebodylength,
    required this.inputarmwidth,
    required this.inputbodywidth,
    required this.distancebetweenbladecentres,
    required this.distancefrombladecentretodronecenter,
  });
}
