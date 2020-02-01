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
        $kolins = $request['kolins'];
        if($kolins == null){
            $posudi = DB::insert("insert into posudba (fk_korisnik,fk_instanca) values ($idkor,$idins)") . "";
        }else{
        $posudi = DB::insert("insert into posudba (fk_korisnik,fk_instanca,kolicina) values ($idkor,$idins,$kolins)") . "";
        }
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
        $posudba = DB::select("select fk_instanca,datum,kolicina from posudba where fk_korisnik = $idkor");
        for($x=0;$x < count($posudba);$x++){
            $id = $posudba[$x]->{"fk_instanca"};
            $ins = DB::select("select * from instanca where id_instanca = $id");
            $posudba[$x]->{'fk_instanca'} = $ins; 
            $idres = $ins[0]->{"fk_resurs"};
            $resurs = DB::select("select * from resurs where id_resurs = $idres");
            $posudba[$x]->{'resurs'} = $resurs;
        }
        return $posudba;

    }

    public function Vrati(Request $request){
        $idkor = $request['idkor'];
        $idins = $request['idins'];
        $vrati = DB::delete("delete from posudba where fk_korisnik = $idkor and fk_instanca = $idins") . "";
        return $vrati; 
    }
}
