<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

use Illuminate\Http\Request;

class LogController extends Controller
{
    public function DodajLog($id_kor,$id_ins,$id_vrsta,$feedback = null){
        DB::insert("insert into log (fk_korisnik,fk_instanca,fk_tip_loga,feedback) values ($id_kor,$id_ins,$id_vrsta,'" . $feedback . "')");

    }

    public function IspisLog($id = null){
        if ($id == null){
            $log = DB::select('select * from log');
        } else {
            $log = DB::select("select * from log where fk_korisnik = $id");
        }
        return $log;
   
    }
}
