import '../models/ResourceType.dart';

class Resource {
  String id;
  String naziv;
  String kategorija;
  int kolicina;
  String imgUrl;
  Duration maxVrijemePosudbe;
  ResourceType tipResursa;
  int zauzeto;

  Resource(this.id, this.naziv, this.kolicina, this.imgUrl,
      this.maxVrijemePosudbe, this.tipResursa,
      [this.zauzeto, this.kategorija]);

  @override
  String toString() {
    return "ID: $id Naziv: $naziv";
  }
}
