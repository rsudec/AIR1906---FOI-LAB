<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

class LogController extends Controller
{
    public function DodajLog($id_kor, $id_ins, $id_vrsta, $feed = null)
    {
        DB::insert("insert into log (fk_korisnik,fk_instanca,fk_tip_loga,feedback) values ($id_kor,$id_ins,$id_vrsta,'" . $feed . "')");

    }

    public function IspisLog($id = null)
    {
        if ($id == null) {
            $log = DB::select(
                "select log.id_log,tip_loga.vrsta,korisnik.kor_ime,korisnik.email,resurs.nazivr,log.datum,log.feedback as feed
                from log
                inner join korisnik as korisnik on log.fk_korisnik = korisnik.id_korisnik
                inner join instanca as instanca on log.fk_instanca = instanca.id_instanca
                inner join resurs as resurs on instanca.fk_resurs = resurs.id_resurs
                inner join tip_loga as tip_loga on log.fk_tip_loga = tip_loga.id_tip_loga");
        } else {
            $log = DB::select(
                "select log.id_log,tip_loga.vrsta,korisnik.kor_ime,korisnik.email,resurs.nazivr,log.datum,log.feedback as feed
                from log
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
        $obavijest = DB::select(
                'select log.id_log,tip_loga.vrsta,korisnik.kor_ime,korisnik.email,resurs.nazivr,log.datum,log.feedback as feed
                from log
                join tip_loga on log.fk_tip_loga = tip_loga.id_tip_loga
                join korisnik on log.fk_korisnik = korisnik.id_korisnik
                join instanca on log.fk_instanca = instanca.id_instanca
                join resurs on instanca.fk_resurs = resurs.id_resurs
                where fk_tip_loga = 5 order by datum desc');
        return $obavijest;
    }

    public function IspisNeprocitanih()
    {
        $obavijest = DB::select(
            'select log.id_log,tip_loga.vrsta,korisnik.kor_ime,korisnik.email,resurs.nazivr,log.datum,log.feedback as feed
            from log
            join tip_loga on log.fk_tip_loga = tip_loga.id_tip_loga
            join korisnik on log.fk_korisnik = korisnik.id_korisnik
            join instanca on log.fk_instanca = instanca.id_instanca
            join resurs on instanca.fk_resurs = resurs.id_resurs
            where (fk_tip_loga = 5 or fk_tip_loga = 6) and procitano = 0 order by datum desc');
        return $obavijest;
    }

    public function ProcitajObavijest($id){
        $procitaj = DB::update("update log set procitano = 1 where id_log = $id");
        return $procitaj;
    }
}
