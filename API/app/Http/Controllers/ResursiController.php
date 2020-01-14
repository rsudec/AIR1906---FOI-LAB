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

    public function DodajResurs($naziv,$kolicina,$slika,$posudba,$tip){
        DB::insert("insert into resurs values ('$naziv',$kolicina,'$slika',$posudba,$tip)");

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
        $svi = DB::select("select resurs.slika, resurs.id_resurs,resurs.nazivr, tip_resursa.nazivtr, count(id_posudba) as zauzeto,resurs.kolicina, resurs.max_posudba from resurs
                    left join instanca on resurs.id_resurs = instanca.fk_resurs
                    left join tip_resursa on resurs.fk_tip_resursa = tip_resursa.id_tip_resursa
                    left join posudba on instanca.id_instanca = posudba.fk_instanca
                    group by resurs.id_resurs,resurs.nazivr,tip_resursa.nazivtr,resurs.kolicina,resurs.max_posudba,resurs.slika "
                );
        return $svi;
    }
    
}
