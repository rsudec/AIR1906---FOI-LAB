<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

class LogController extends Controller
{
    public function DodajLog($id_kor, $id_ins, $id_vrsta, $feedback = null)
    {
        DB::insert("insert into log (fk_korisnik,fk_instanca,fk_tip_loga,feedback) values ($id_kor,$id_ins,$id_vrsta,'" . $feedback . "')");

    }

    public function IspisLog($id = null)
    {
        if ($id == null) {
            $log = DB::select("select tip_loga.vrsta,korisnik.kor_ime,korisnik.email,resurs.naziv,log.datum,log.feedback
                from log as log
                inner join korisnik as korisnik on log.fk_korisnik = korisnik.id_korisnik
                inner join instanca as instanca on log.fk_instanca = instanca.id_instanca
                inner join resurs as resurs on instanca.fk_resurs = resurs.id_resurs
                inner join tip_loga as tip_loga on log.fk_tip_loga = tip_loga.id_tip_loga");
        } else {
            $log = DB::select(
                "select tip_loga.vrsta,korisnik.kor_ime,korisnik.email,resurs.naziv,log.datum,log.feedback
                from log as log
                inner join korisnik as korisnik on log.fk_korisnik = korisnik.id_korisnik
                inner join instanca as instanca on log.fk_instanca = instanca.id_instanca
                inner join resurs as resurs on instanca.fk_resurs = resurs.id_resurs
                inner join tip_loga as tip_loga on log.fk_tip_loga = tip_loga.id_tip_loga
                where fk_korisnik = $id");
        }
        return $log;

    }

    public function IspisObavijesti()
    {
        $obavijest = DB::select('select * from log where fk_tip_loga = 5 order by datum desc');
        return $obavijest;
    }

    public function IspisNeprocitanih()
    {
        $obavijest = DB::select('select * from log where fk_tip_loga = 5 and procitano = 0 order by datum desc');
        return $obavijest;
    }
}
