<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;

class KorisnikController extends Controller
{
    public function Prijava(Request $request){
        
        $korime = $request->get('korime');
        $lozinka = $request->get('lozinka');
        $korisnik = DB::select("SELECT * from korisnik where kor_ime = '$korime' and lozinka = '$lozinka'");
        return $korisnik;

        }
    
    public function SviKorisnici(){
        $korisnik = DB::select('SELECT * from korisnik');
        return $korisnik;
    }

    public function ProvjeraKorisnika(Request $request){
        $korime = $request->get('korime');
        $lozinka = $request->get('lozinka');
        
        return $provjera;

    }
    public function DodajKorisnika(Request $request){
        $ime = $request->get('ime');
        $prezime = $request->get('prezime');
        $telefon = $request->get('telefon');
        $adresa = $request->get('adresa');
        $email = $request->get('email');
        $oib = $request->get('oib');
        $korime = $request->get('korime');
        $lozinka = $request->get('lozinka');
        $poslovnica = $request->get('poslovnica');
        
        $provjera = DB::select("select * from korisnik where kor_ime = '$korime' or email = '$email'");
        if(!empty($provjera)){
            return abort(418,'postoji korisnicko ime ili email');
        }else
        {
        $dodaj = DB::insert("insert into korisnik values ('$ime','$prezime','$telefon','$adresa','$email','$oib','$korime','$lozinka',2,$poslovnica)");
        $dodaj = json_decode($dodaj);
        return $dodaj;
        }
    }

    public function SvePoslovnice(){
        $poslovnice = DB::select("select * from poslovnica");
        return $poslovnice;
    }


}

