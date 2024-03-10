class Demande {
  final int id;
  final String date;
  final String state;
  final List<dynamic> prod;
  final List<String> produitImages;

  const Demande({
    required this.id,
    required this.state,
    required this.date,
    required this.prod,
    required this.produitImages,

  });
}