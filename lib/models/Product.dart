class Product {
  final int id;
  final int montant;
  final String produit;
  final bool state;
  final String montantRembourse;
  final String description;
  final String qrcode;
  final String datefinal;
  final List<String> produitImages;

  const Product({
    required this.id,
    required this.montant,
    required this.produit,
    required this.state,
    required this.montantRembourse,
    required this.description,
    required this.qrcode,
    required this.datefinal,
    required this.produitImages,
  });
}