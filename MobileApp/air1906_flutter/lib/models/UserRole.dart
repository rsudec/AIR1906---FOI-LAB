class UserRole {
  String id;
  String naziv;
  String opis;

  UserRole(id){
    this.id = id;
    if(id == 1){
      this.naziv = "Admin";
      this.opis = "Admininstrator";
    }
    else{
      this.naziv = "User";
      this.opis = "Korisnik";
    }
  }
}