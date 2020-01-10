<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;

class DBController extends Controller
{
    public function ShowUsers(){
        $users = DB::select('SELECT * from korisnik');
        return $users;
    }
}
