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
        var_dump($resurs);
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

    
}
