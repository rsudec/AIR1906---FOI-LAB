<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;

class KorisnikController extends Controller
{
    public function Prijava($korime,$lozinka){
        $korisnik = DB::select("SELECT fk_uloga from korisnik where kor_ime = '$korime' and lozinka = '$lozinka'");
        if (empty($korisnik)){
            return false;
        }else{
            return $korisnik;
            }

        }
    
    public function SviKorisnici(){
        $korisnik = DB::select('SELECT * from korisnik');
        return $korisnik;
    }

    public function DodajKorisnika($ime,$prezime,$telefon,$adresa,$email,$oib,$korime,$lozinka,$poslovnica){
        DB::insert("insert into korisnik values ('$ime','$prezime','$telefon','$adresa','$email','$oib','$korime','$lozinka',2,$poslovnica)");

    }


}

