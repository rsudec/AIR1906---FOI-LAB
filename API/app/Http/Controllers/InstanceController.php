<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;

class InstanceController extends Controller
{
    public function SlobodneInstance(){
        $instance = DB::select('SELECT * from instanca where slobodno = 1');
        return $instance;
    }

    public function ZauzeteInstance(){
        $instance = DB::select('SELECT * from instanca where slobodno = 0');
        return $instance;
    }

    public function TraziInstancu($naziv){
        $trazi = '%'. $naziv . '%';
        $instance = DB::select("select resurs.nazivr from resurs join instanca on resurs.id_resurs = instanca.fk_resurs where resurs.nazivr like '$trazi'");
        return $instance;

    }

    public function InstancePoResursu($id){
        $rezultat = DB::select(
            "select instanca.id_instanca,korisnik.kor_ime, korisnik.email,posudba.datum from instanca
            left join resurs on instanca.fk_resurs = resurs.id_resurs
            left join posudba on instanca.id_instanca = posudba.fk_instanca
            left join korisnik on posudba.fk_korisnik = korisnik.id_korisnik
            where instanca.fk_resurs = $id");
        return $rezultat;
    }

    public function Pozicija($id){
        $pozicija = DB::select("select distinct k1.naziv as polica,k2.naziv as ormar  from instanca
        left join kontejner as k1 on instanca.fk_kontejner = k1.id_kontejner
        left join kontejner as k2 on k1.fk_kontejner = k2.id_kontejner 
        where fk_resurs = $id");
        return $pozicija;

    }

    public function Qr($idres,$idkon){
        $qr = DB::select("select id_instanca from instanca where fk_resurs = $idres and fk_kontejner = $idkon");
        return $qr;
    }

    public function DodajInstancu(Request $request){
        $idres = $request["idres"];
        $idkon = $request["idkon"];
        $kolicina = $request["kolicina"];
        $upit = DB::insert("insert into instanca (fk_resurs,fk_kontejner,kolicina) values ($idres,$idkon,$kolicina)");
        return $upit . "";
    }

    public function NfcSpreman($id){
        $spreman = DB::update("update instanca set nfc = 1 where id_instanca = $id");
        return $spreman . "";
    }

    public function NfcPriprava(){
        $priprava = DB::select("select * from instanca where nfc = 0");
        $rezultat= [];
        for($x=0;$x < count($priprava);$x++){
            $idres = $priprava[$x]->{"fk_resurs"};
            $resurs = DB::select("select * from resurs where id_resurs = $idres");
            $priprava[$x]->{"fk_resurs"} = $resurs;

        }
        return $priprava;
    }

    public function InstancaId($id){
        $instanca = DB::select("select * from instanca where id_instanca = $id");
        
        for($x=0;$x < count($instanca);$x++){
            $idres = $instanca[$x]->{"fk_resurs"};
            $resurs = DB::select("select * from resurs where id_resurs = $idres");
            $instanca[$x]->{"fk_resurs"} = $resurs;

        }

        return $instanca;
    }
}
