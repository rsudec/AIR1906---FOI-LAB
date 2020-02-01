<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
 */

Route::get('/', function () {
    return view('welcome');
});

Route::get('/ShowUsers', 'DBController@ShowUsers');
//Instance//
Route::get('/SlobodneInstance', 'InstanceController@SlobodneInstance');
Route::get('/ZauzeteInstance', 'InstanceController@ZauzeteInstance');
Route::get('/TraziInstancu/{naziv}', 'InstanceController@TraziInstancu');
Route::get('/InstancePoResursu/{id}','InstanceController@InstancePoResursu');
Route::get('/Pozicija/{id}','InstanceController@Pozicija');
Route::post('/DodajInstancu','InstanceController@DodajInstancu');
Route::get('/Qr/{idres}/{idkon}','InstanceController@Qr');
Route::get('/NfcSpreman/{id}','InstanceController@NfcSpreman');
Route::get('/NfcPriprava','InstanceController@NfcPriprava');
Route::get('/InstancaId/{id}','InstanceController@InstancaId');
//Resursi//
Route::get('/VrsteResursa', 'ResursiController@VrsteResursa');
Route::get('/TraziPoVrsti/{id}', 'ResursiController@TraziPoVrsti');
Route::post('/DodajResurs', 'ResursiController@DodajResurs');
Route::get('/TraziPoVrsti2/{id}', 'ResursiController@TraziPoVrsti2');
Route::get('/TraziPoVrsti3/{id}','ResursiController@TraziPoVrsti3');
Route::get('/MojiResursi/{id}', 'ResursiController@MojiResursi');
Route::get('/SviResursi','ResursiController@SviResursi');
Route::post('/Azuriraj','ResursiController@Azuriraj');
Route::get('/Skladista','ResursiController@Skladista');
Route::get('/SlobodniKontejneri','ResursiController@SlobodniKontejneri');
//Log//
Route::get('/DodajLog/{id_kor}/{id_ins}/{id_vrsta}/{feedback?}', 'LogController@DodajLog');
Route::get('/IspisLog/{id_kor?}', 'LogController@IspisLog');
Route::get('/IspisObavijesti', 'LogController@IspisObavijesti');
Route::get('/IspisNeprocitanih', 'LogController@IspisNeprocitanih');
Route::get('/ProcitajObavijest/{id}','LogController@ProcitajObavijest');
//Korisnik//
Route::post('/Prijava', 'KorisnikController@Prijava');
Route::get('/SviKorisnici', 'KorisnikController@SviKorisnici');
Route::post('/DodajKorisnika', 'KorisnikController@DodajKorisnika');
Route::get('/SvePoslovnice', 'KorisnikController@SvePoslovnice');
Route::post('/AzurirajKorisnika','KorisnikController@AzurirajKorisnika');
//Posudbe//
Route::get('/MojePosudbe/{id}', 'PosudbaController@MojePosudbe');
Route::get('/MojePosudbe2/{id}','PosudbaController@MojePosudbe2');
Route::post('/Posudi', 'PosudbaController@Posudi');
Route::post('/Vrati','PosudbaController@Vrati');
