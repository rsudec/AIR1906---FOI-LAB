<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;

class ResursiController extends Controller
{
    public function VrsteResursa(){
        $resurs = DB::select('select * from tip_resursa');
        return $resurs;
    }

    public function TraziPoVrsti($id){
        $resurs = DB::select("select * from resurs where resurs.fk_tip_resursa = $id ");
        return $resurs;

    }

    public function TraziPoVrsti3($id){
        $povrsti = DB::select("select resurs.slika, resurs.id_resurs,resurs.nazivr, tip_resursa.nazivtr, sum(P.kolicina) as zauzeto,resurs.kolicina, resurs.max_posudba from resurs
                    left join instanca on resurs.id_resurs = instanca.fk_resurs
                    left join tip_resursa on resurs.fk_tip_resursa = tip_resursa.id_tip_resursa
                    left join posudba as P on instanca.id_instanca = P.fk_instanca
                    where fk_tip_resursa = $id
                    group by resurs.id_resurs,resurs.nazivr,tip_resursa.nazivtr,resurs.kolicina,resurs.max_posudba,resurs.slika "
                );
    for($x=0;$x < count($povrsti);$x++){
        if($povrsti[$x]->{"zauzeto"} == null){
            $povrsti[$x]->{"zauzeto"} = 0 ."";
        }
                }
        return $povrsti;

    }

    public function DodajResurs(Request $request){

        $naziv = $request["naziv"];
        $kolicina = $request["kolicina"];
        $slika = $request["slika"];
        $posudba = $request["posudba"];
        $tip = $request["tip"];
        $novi = DB::insert("insert into resurs values ('$naziv',$kolicina,'$slika',$posudba,$tip)");
        return $novi . "";

    }

    public function TraziPoVrsti2($id){
        $resurs = DB::select("select * from resurs where resurs.fk_tip_resursa = $id ");
        $tip = DB::select("select * from tip_resursa where id_tip_resursa = $id");
        for($x=0;$x < count($resurs);$x++){
            $resurs[$x]->{'fk_tip_resursa'} = $tip;
        }
        return $resurs;

    }

    public function MojiResursi($id){
        $moji = DB::select("select * from log inner join instanca on log.fk_instanca = instanca.id_instanca inner join resurs on instanca.fk_resurs = resurs.id_resurs");
        return $moji;
    }

    public function SviResursi(){
        $svi = DB::select("select resurs.slika, resurs.id_resurs,resurs.nazivr, tip_resursa.nazivtr, sum(P.kolicina) as zauzeto,resurs.kolicina, resurs.max_posudba from resurs
                    left join instanca on resurs.id_resurs = instanca.fk_resurs
                    left join tip_resursa on resurs.fk_tip_resursa = tip_resursa.id_tip_resursa
                    left join posudba as P on instanca.id_instanca = P.fk_instanca
                    group by resurs.id_resurs,resurs.nazivr,tip_resursa.nazivtr,resurs.kolicina,resurs.max_posudba,resurs.slika "
                );
    for($x=0;$x < count($svi);$x++){
        if($svi[$x]->{"zauzeto"} == null){
            $svi[$x]->{"zauzeto"} = 0 ."";
        }
                }
        return $svi;
    }
    
    public function Azuriraj(Request $request){
        $id = $request["id"];
        $naziv = $request["naziv"];
        $kolicina = $request["kolicina"];
        $slika = $request["slika"];
        $posudba = $request["posudba"];
        $azuriraj = DB::update("update resurs set nazivr = '$naziv',kolicina = $kolicina, slika = '$slika',max_posudba = $posudba where id_resurs = $id");
        return $azuriraj . "";

    }

    public function Skladista(){
        $skladista=DB::select("select * from skladiste");
        return $skladista;
    }


    public function SlobodniKontejneri(){
        $slobodni = DB::select('select kontejner.id_kontejner, kontejner.naziv from 
        kontejner where not exists (select fk_kontejner from instanca
        where kontejner.id_kontejner = instanca.fk_kontejner) and kontejner.fk_kontejner is not null');
        return $slobodni;
    }

    public function DodajTip(Request $request){
        $naziv = $request["naziv"];
        $opis = $request["opis"];
        $novitip = DB::insert("insert into tip_resursa (nazivtr,opis) values ('$naziv','$opis')");
        return $novitip . "";

    }

    public function DodajKontejner($naziv,$skladiste,$ormar = null){
        $kontejner =DB::insert("insert into kontejner (naziv,fk_skladiste,fk_kontejner) values ('$naziv',$skladiste,$ormar)");
        return $kontejner . "";

    }

    public function Ormari(){
        $ormari = DB::select("select * from kontejner where fk_kontejner is null");
        return $ormari;
    }

    public function Police($id){
        $police = DB::select("select * from kontejner where fk_kontejner = $id");
        return $police;

    }

    public function Police2($id){
        $police = DB::select("select * from kontejner where fk_kontejner = $id AND not exists(select * from instanca where fk_kontejner = id_kontejner)");
        return $police;
    }


}
