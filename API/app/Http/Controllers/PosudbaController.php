<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;


class PosudbaController extends Controller
{
    public function Posudi(Request $request)
    {
        $idkor = $request['idkor'];
        $idins = $request['idins'];
        $posudi = DB::insert("insert into posudba (fk_korisnik,fk_instanca) values ($idkor,$idins)") . "";
        return $posudi;
    }

    public function MojePosudbe($idkor)
    {
        $moje = DB::select("select nazivr,nazivtr,datum from posudba
        join instanca on posudba.fk_instanca = instanca.id_instanca
        join resurs on instanca.fk_resurs = resurs.id_resurs
        join tip_resursa on resurs.fk_tip_resursa = tip_resursa.id_tip_resursa
        where posudba.fk_korisnik = $idkor");
        return $moje;
    }

    public function MojePosudbe2($idkor){
        $posudba = DB::select("select fk_instanca,datum from posudba where fk_korisnik = $idkor");
        $rezultat= [];
        for($x=0;$x < count($posudba);$x++){
            $idins = $posudba[$x]->{"fk_instanca"};
            $datum = $posudba[$x]->{"datum"};
            $ins = DB::select("select * from instanca where id_instanca = $idins");
            $idres = $ins[0]->{"fk_resurs"};
            $resurs = DB::select("select * from resurs where id_resurs = $idres");
            $ins[0]->{"fk_resurs"} = $resurs;
            $ins[0]->{"datum"} = $datum;
            array_push($rezultat,$ins);

        }
        return $rezultat;
        
        //return $posudba;


    }

    public function Vrati(Request $request){
        $idkor = $request['idkor'];
        $idins = $request['idins'];
        $vrati = DB::delete("delete from posudba where fk_korisnik = $idkor and fk_instanca = $idins") . "";
        return $vrati; 
    }
}
