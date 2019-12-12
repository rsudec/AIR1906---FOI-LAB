class Resource {
  String id;
  String naziv;
  int kolicina;
  String imgUrl;
  Duration maxVrijemePosudbe;
  // ResourceType tipResursa;

  Resource(this.id, this.naziv,this.kolicina, this.imgUrl, this.maxVrijemePosudbe);

  @override
  String toString() {
    return "ID: $id Naziv: $naziv"; 
    }
}