import './Resource.dart';

class ResourceInstance {
  String id;
  int kolicina;
  Resource resource;
  DateTime datumPosudbe;

  ResourceInstance(this.id, this.kolicina, this.resource, [this.datumPosudbe]);

  @override
  String toString() {
    return "INSTANCA $id / kolicina $kolicina / resurs $resource ";
  }
}
