<?php


class Baza
{
    const server = "air1906.database.windows.net";
    const baza = "AiR1906";
    const korisnik="air1906";
    const  lozinka ="1906Xx6091";


   function SpojiDB(){
       $connectionInfo=array("UID"=>self::korisnik, "PWD"=>self::lozinka,
           "Database"=>self::baza);
       $conn = sqlsrv_connect(self::server, $connectionInfo);
       if(!$conn){
           echo 'Greška prilikom spajanja na bazu';
           exit();
       }
       return $conn;
   }

   function UpitDB($upit){
       $conn=self::SpojiDB();
       $rezultat=sqlsrv_query($conn,$upit);
       if (!$rezultat){
           $rezultat=null;
           echo 'Greška kod upita na bazu!';
           exit();
       }
       return $rezultat;
   }

}