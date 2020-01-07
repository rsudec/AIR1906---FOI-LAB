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
}
