---
title: API Reference

language_tabs:
- bash
- javascript

includes:

search: true

toc_footers:
- <a href='http://github.com/mpociot/documentarian'>Documentation Powered by Documentarian</a>
---
<!-- START_INFO -->
# Info

Welcome to the generated API reference.
[Get Postman Collection](http://localhost/docs/collection.json)

<!-- END_INFO -->

#general


<!-- START_89632a6d9f2c8d2d3e04c19d9e360b5a -->
## TraziInstancu/{naziv}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/TraziInstancu/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/TraziInstancu/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[]
```

### HTTP Request
`GET TraziInstancu/{naziv}`


<!-- END_89632a6d9f2c8d2d3e04c19d9e360b5a -->

<!-- START_67a454a5f07b791dbf78c2527c32a33f -->
## InstancePoResursu/{id}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/InstancePoResursu/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/InstancePoResursu/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_instanca": "1",
        "kor_ime": null,
        "email": null,
        "datum": null
    },
    {
        "id_instanca": "15",
        "kor_ime": "isudec",
        "email": "isudec@foi.hr",
        "datum": "2020-01-31 21:19:51.623"
    },
    {
        "id_instanca": "16",
        "kor_ime": null,
        "email": null,
        "datum": null
    }
]
```

### HTTP Request
`GET InstancePoResursu/{id}`


<!-- END_67a454a5f07b791dbf78c2527c32a33f -->

<!-- START_3fc0890cb321a6a5ddca56df54b1854b -->
## Pozicija/{id}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/Pozicija/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/Pozicija/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "polica": "Polica 1",
        "ormar": "Ormar A"
    }
]
```

### HTTP Request
`GET Pozicija/{id}`


<!-- END_3fc0890cb321a6a5ddca56df54b1854b -->

<!-- START_05b396994527fc9924ea827753fe7001 -->
## DodajInstancu
> Example request:

```bash
curl -X POST \
    "http://localhost/DodajInstancu" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/DodajInstancu"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST DodajInstancu`


<!-- END_05b396994527fc9924ea827753fe7001 -->

<!-- START_84d389ae687778b0e2657fe0a90f8b55 -->
## Qr/{idres}/{idkon}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/Qr/1/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/Qr/1/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[]
```

### HTTP Request
`GET Qr/{idres}/{idkon}`


<!-- END_84d389ae687778b0e2657fe0a90f8b55 -->

<!-- START_0196cc2a1d24dc94e62f1b58056fa613 -->
## NfcSpreman/{id}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/NfcSpreman/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/NfcSpreman/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
1
```

### HTTP Request
`GET NfcSpreman/{id}`


<!-- END_0196cc2a1d24dc94e62f1b58056fa613 -->

<!-- START_968a12d0b356abb68ce72fb6d5b6a7bc -->
## NfcPriprava
> Example request:

```bash
curl -X GET \
    -G "http://localhost/NfcPriprava" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/NfcPriprava"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_instanca": "17",
        "kolicina": "1",
        "fk_resurs": [
            {
                "id_resurs": "5",
                "nazivr": "Klamerica RAPID",
                "kolicina": "2",
                "slika": "klamerica.jpg",
                "max_posudba": "7",
                "fk_tip_resursa": "2"
            }
        ],
        "fk_kontejner": "4",
        "nfc": "0"
    },
    {
        "id_instanca": "18",
        "kolicina": "1",
        "fk_resurs": [
            {
                "id_resurs": "5",
                "nazivr": "Klamerica RAPID",
                "kolicina": "2",
                "slika": "klamerica.jpg",
                "max_posudba": "7",
                "fk_tip_resursa": "2"
            }
        ],
        "fk_kontejner": "4",
        "nfc": "0"
    },
    {
        "id_instanca": "19",
        "kolicina": "1",
        "fk_resurs": [
            {
                "id_resurs": "2",
                "nazivr": "Super Klamer 4200",
                "kolicina": "3",
                "slika": "",
                "max_posudba": "8",
                "fk_tip_resursa": "2"
            }
        ],
        "fk_kontejner": "3",
        "nfc": "0"
    }
]
```

### HTTP Request
`GET NfcPriprava`


<!-- END_968a12d0b356abb68ce72fb6d5b6a7bc -->

<!-- START_9b350ee592135ce3a4119226bf7b8b1d -->
## InstancaId/{id}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/InstancaId/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/InstancaId/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_instanca": "1",
        "kolicina": "1",
        "fk_resurs": [
            {
                "id_resurs": "1",
                "nazivr": "HP 3000",
                "kolicina": "3",
                "slika": "laptop.jpg",
                "max_posudba": "4",
                "fk_tip_resursa": "1"
            }
        ],
        "fk_kontejner": "2",
        "nfc": "1"
    }
]
```

### HTTP Request
`GET InstancaId/{id}`


<!-- END_9b350ee592135ce3a4119226bf7b8b1d -->

<!-- START_96ac7d5b775c0ad3f1cdf93cf9cf5c24 -->
## VrsteResursa
> Example request:

```bash
curl -X GET \
    -G "http://localhost/VrsteResursa" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/VrsteResursa"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_tip_resursa": "1",
        "nazivtr": "laptop",
        "opis": "prjenosna racunala"
    },
    {
        "id_tip_resursa": "2",
        "nazivtr": "klamerica",
        "opis": "zakvacke"
    },
    {
        "id_tip_resursa": "3",
        "nazivtr": "mobitel",
        "opis": "mobilni telefoni"
    },
    {
        "id_tip_resursa": "4",
        "nazivtr": "nfc",
        "opis": "chipovi"
    },
    {
        "id_tip_resursa": "5",
        "nazivtr": "olovka",
        "opis": "pisalo na bazi grafita"
    }
]
```

### HTTP Request
`GET VrsteResursa`


<!-- END_96ac7d5b775c0ad3f1cdf93cf9cf5c24 -->

<!-- START_cc263d834b6b9e991af949574e442db6 -->
## TraziPoVrsti/{id}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/TraziPoVrsti/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/TraziPoVrsti/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_resurs": "1",
        "nazivr": "HP 3000",
        "kolicina": "3",
        "slika": "laptop.jpg",
        "max_posudba": "4",
        "fk_tip_resursa": "1"
    },
    {
        "id_resurs": "3",
        "nazivr": "ACER Giga X",
        "kolicina": "1",
        "slika": "",
        "max_posudba": "7",
        "fk_tip_resursa": "1"
    },
    {
        "id_resurs": "4",
        "nazivr": "Lenovo PubG Drop Hunter v2",
        "kolicina": "1",
        "slika": "",
        "max_posudba": "7",
        "fk_tip_resursa": "1"
    },
    {
        "id_resurs": "6",
        "nazivr": "LENOVO IdeaPad S145",
        "kolicina": "0",
        "slika": "lenovo.jpg",
        "max_posudba": "10",
        "fk_tip_resursa": "1"
    },
    {
        "id_resurs": "7",
        "nazivr": "Acer Aspire 3",
        "kolicina": "0",
        "slika": "acer.jpg",
        "max_posudba": "10",
        "fk_tip_resursa": "1"
    },
    {
        "id_resurs": "8",
        "nazivr": "LENOVO IdeaPad S156",
        "kolicina": "0",
        "slika": "lenovo.jpg",
        "max_posudba": "10",
        "fk_tip_resursa": "1"
    }
]
```

### HTTP Request
`GET TraziPoVrsti/{id}`


<!-- END_cc263d834b6b9e991af949574e442db6 -->

<!-- START_51c4436ef173d3d89aedd7c58531c0db -->
## DodajResurs
> Example request:

```bash
curl -X POST \
    "http://localhost/DodajResurs" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/DodajResurs"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST DodajResurs`


<!-- END_51c4436ef173d3d89aedd7c58531c0db -->

<!-- START_92b011845d4ddcac145c03587a105196 -->
## TraziPoVrsti2/{id}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/TraziPoVrsti2/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/TraziPoVrsti2/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_resurs": "1",
        "nazivr": "HP 3000",
        "kolicina": "3",
        "slika": "laptop.jpg",
        "max_posudba": "4",
        "fk_tip_resursa": [
            {
                "id_tip_resursa": "1",
                "nazivtr": "laptop",
                "opis": "prjenosna racunala"
            }
        ]
    },
    {
        "id_resurs": "3",
        "nazivr": "ACER Giga X",
        "kolicina": "1",
        "slika": "",
        "max_posudba": "7",
        "fk_tip_resursa": [
            {
                "id_tip_resursa": "1",
                "nazivtr": "laptop",
                "opis": "prjenosna racunala"
            }
        ]
    },
    {
        "id_resurs": "4",
        "nazivr": "Lenovo PubG Drop Hunter v2",
        "kolicina": "1",
        "slika": "",
        "max_posudba": "7",
        "fk_tip_resursa": [
            {
                "id_tip_resursa": "1",
                "nazivtr": "laptop",
                "opis": "prjenosna racunala"
            }
        ]
    },
    {
        "id_resurs": "6",
        "nazivr": "LENOVO IdeaPad S145",
        "kolicina": "0",
        "slika": "lenovo.jpg",
        "max_posudba": "10",
        "fk_tip_resursa": [
            {
                "id_tip_resursa": "1",
                "nazivtr": "laptop",
                "opis": "prjenosna racunala"
            }
        ]
    },
    {
        "id_resurs": "7",
        "nazivr": "Acer Aspire 3",
        "kolicina": "0",
        "slika": "acer.jpg",
        "max_posudba": "10",
        "fk_tip_resursa": [
            {
                "id_tip_resursa": "1",
                "nazivtr": "laptop",
                "opis": "prjenosna racunala"
            }
        ]
    },
    {
        "id_resurs": "8",
        "nazivr": "LENOVO IdeaPad S156",
        "kolicina": "0",
        "slika": "lenovo.jpg",
        "max_posudba": "10",
        "fk_tip_resursa": [
            {
                "id_tip_resursa": "1",
                "nazivtr": "laptop",
                "opis": "prjenosna racunala"
            }
        ]
    }
]
```

### HTTP Request
`GET TraziPoVrsti2/{id}`


<!-- END_92b011845d4ddcac145c03587a105196 -->

<!-- START_75168c8b46fc6a5646389552c4d07f3e -->
## TraziPoVrsti3/{id}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/TraziPoVrsti3/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/TraziPoVrsti3/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "slika": "laptop.jpg",
        "id_resurs": "1",
        "nazivr": "HP 3000",
        "nazivtr": "laptop",
        "zauzeto": "1",
        "kolicina": "3",
        "max_posudba": "4"
    },
    {
        "slika": "",
        "id_resurs": "3",
        "nazivr": "ACER Giga X",
        "nazivtr": "laptop",
        "zauzeto": "0",
        "kolicina": "1",
        "max_posudba": "7"
    },
    {
        "slika": "",
        "id_resurs": "4",
        "nazivr": "Lenovo PubG Drop Hunter v2",
        "nazivtr": "laptop",
        "zauzeto": "0",
        "kolicina": "1",
        "max_posudba": "7"
    },
    {
        "slika": "lenovo.jpg",
        "id_resurs": "6",
        "nazivr": "LENOVO IdeaPad S145",
        "nazivtr": "laptop",
        "zauzeto": "0",
        "kolicina": "0",
        "max_posudba": "10"
    },
    {
        "slika": "acer.jpg",
        "id_resurs": "7",
        "nazivr": "Acer Aspire 3",
        "nazivtr": "laptop",
        "zauzeto": "0",
        "kolicina": "0",
        "max_posudba": "10"
    },
    {
        "slika": "lenovo.jpg",
        "id_resurs": "8",
        "nazivr": "LENOVO IdeaPad S156",
        "nazivtr": "laptop",
        "zauzeto": "0",
        "kolicina": "0",
        "max_posudba": "10"
    }
]
```

### HTTP Request
`GET TraziPoVrsti3/{id}`


<!-- END_75168c8b46fc6a5646389552c4d07f3e -->

<!-- START_35ea8a0580bd614984fda0ca5a6c87aa -->
## MojiResursi/{id}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/MojiResursi/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/MojiResursi/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_log": "3",
        "datum": "2020-01-07 18:37:58.357",
        "fk_korisnik": "1",
        "fk_instanca": "2",
        "fk_tip_loga": "1",
        "feedback": "",
        "procitano": "1",
        "id_instanca": "2",
        "kolicina": "3",
        "fk_resurs": "2",
        "fk_kontejner": "2",
        "nfc": "1",
        "id_resurs": "2",
        "nazivr": "Super Klamer 4200",
        "slika": "",
        "max_posudba": "8",
        "fk_tip_resursa": "2"
    },
    {
        "id_log": "7",
        "datum": "2020-01-08 12:27:30.240",
        "fk_korisnik": "2",
        "fk_instanca": "2",
        "fk_tip_loga": "5",
        "feedback": "Zaklamo sam se",
        "procitano": "0",
        "id_instanca": "2",
        "kolicina": "3",
        "fk_resurs": "2",
        "fk_kontejner": "2",
        "nfc": "1",
        "id_resurs": "2",
        "nazivr": "Super Klamer 4200",
        "slika": "",
        "max_posudba": "8",
        "fk_tip_resursa": "2"
    },
    {
        "id_log": "8",
        "datum": "2020-01-08 12:29:38.907",
        "fk_korisnik": "2",
        "fk_instanca": "2",
        "fk_tip_loga": "5",
        "feedback": "Odklamao sam se uspjesno",
        "procitano": "1",
        "id_instanca": "2",
        "kolicina": "3",
        "fk_resurs": "2",
        "fk_kontejner": "2",
        "nfc": "1",
        "id_resurs": "2",
        "nazivr": "Super Klamer 4200",
        "slika": "",
        "max_posudba": "8",
        "fk_tip_resursa": "2"
    },
    {
        "id_log": "14",
        "datum": "2020-01-15 08:55:28.460",
        "fk_korisnik": "1",
        "fk_instanca": "1",
        "fk_tip_loga": "6",
        "feedback": "Polomljen ekran",
        "procitano": "0",
        "id_instanca": "1",
        "kolicina": "3",
        "fk_resurs": "1",
        "fk_kontejner": "2",
        "nfc": "1",
        "id_resurs": "1",
        "nazivr": "HP 3000",
        "slika": "laptop.jpg",
        "max_posudba": "4",
        "fk_tip_resursa": "1"
    },
    {
        "id_log": "15",
        "datum": "2020-01-15 12:02:06.823",
        "fk_korisnik": "1",
        "fk_instanca": "4",
        "fk_tip_loga": "6",
        "feedback": "wow joj jaoooo",
        "procitano": "0",
        "id_instanca": "4",
        "kolicina": "1",
        "fk_resurs": "3",
        "fk_kontejner": "2",
        "nfc": "1",
        "id_resurs": "3",
        "nazivr": "ACER Giga X",
        "slika": "",
        "max_posudba": "7",
        "fk_tip_resursa": "1"
    },
    {
        "id_log": "16",
        "datum": "2020-01-22 16:22:46.647",
        "fk_korisnik": "1",
        "fk_instanca": "4",
        "fk_tip_loga": "6",
        "feedback": "hahahahaha",
        "procitano": "0",
        "id_instanca": "4",
        "kolicina": "1",
        "fk_resurs": "3",
        "fk_kontejner": "2",
        "nfc": "1",
        "id_resurs": "3",
        "nazivr": "ACER Giga X",
        "slika": "",
        "max_posudba": "7",
        "fk_tip_resursa": "1"
    },
    {
        "id_log": "17",
        "datum": "2020-01-24 14:40:03.283",
        "fk_korisnik": "1",
        "fk_instanca": "1",
        "fk_tip_loga": "6",
        "feedback": "EVO TI komentar  ",
        "procitano": "1",
        "id_instanca": "1",
        "kolicina": "3",
        "fk_resurs": "1",
        "fk_kontejner": "2",
        "nfc": "1",
        "id_resurs": "1",
        "nazivr": "HP 3000",
        "slika": "laptop.jpg",
        "max_posudba": "4",
        "fk_tip_resursa": "1"
    }
]
```

### HTTP Request
`GET MojiResursi/{id}`


<!-- END_35ea8a0580bd614984fda0ca5a6c87aa -->

<!-- START_8e18561d68ac6f153815a44b8fc6185b -->
## SviResursi
> Example request:

```bash
curl -X GET \
    -G "http://localhost/SviResursi" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/SviResursi"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "slika": "",
        "id_resurs": "2",
        "nazivr": "Super Klamer 4200",
        "nazivtr": "klamerica",
        "zauzeto": "0",
        "kolicina": "3",
        "max_posudba": "8"
    },
    {
        "slika": "klamerica.jpg",
        "id_resurs": "5",
        "nazivr": "Klamerica RAPID",
        "nazivtr": "klamerica",
        "zauzeto": "0",
        "kolicina": "2",
        "max_posudba": "7"
    },
    {
        "slika": "laptop.jpg",
        "id_resurs": "1",
        "nazivr": "HP 3000",
        "nazivtr": "laptop",
        "zauzeto": "1",
        "kolicina": "3",
        "max_posudba": "4"
    },
    {
        "slika": "",
        "id_resurs": "3",
        "nazivr": "ACER Giga X",
        "nazivtr": "laptop",
        "zauzeto": "0",
        "kolicina": "1",
        "max_posudba": "7"
    },
    {
        "slika": "",
        "id_resurs": "4",
        "nazivr": "Lenovo PubG Drop Hunter v2",
        "nazivtr": "laptop",
        "zauzeto": "0",
        "kolicina": "1",
        "max_posudba": "7"
    },
    {
        "slika": "lenovo.jpg",
        "id_resurs": "6",
        "nazivr": "LENOVO IdeaPad S145",
        "nazivtr": "laptop",
        "zauzeto": "0",
        "kolicina": "0",
        "max_posudba": "10"
    },
    {
        "slika": "acer.jpg",
        "id_resurs": "7",
        "nazivr": "Acer Aspire 3",
        "nazivtr": "laptop",
        "zauzeto": "0",
        "kolicina": "0",
        "max_posudba": "10"
    },
    {
        "slika": "lenovo.jpg",
        "id_resurs": "8",
        "nazivr": "LENOVO IdeaPad S156",
        "nazivtr": "laptop",
        "zauzeto": "0",
        "kolicina": "0",
        "max_posudba": "10"
    },
    {
        "slika": "Screenshot_9.png",
        "id_resurs": "10",
        "nazivr": "Jako dobra olovka",
        "nazivtr": "olovka",
        "zauzeto": "0",
        "kolicina": "100",
        "max_posudba": "21"
    }
]
```

### HTTP Request
`GET SviResursi`


<!-- END_8e18561d68ac6f153815a44b8fc6185b -->

<!-- START_b0a751c9255a2dd9aa074343fe540deb -->
## Azuriraj
> Example request:

```bash
curl -X POST \
    "http://localhost/Azuriraj" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/Azuriraj"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST Azuriraj`


<!-- END_b0a751c9255a2dd9aa074343fe540deb -->

<!-- START_226e219adf707e87fbe1e6f16766f653 -->
## Skladista
> Example request:

```bash
curl -X GET \
    -G "http://localhost/Skladista" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/Skladista"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_skladiste": "1",
        "lokacija": "Vodnikova",
        "velicina(m2)": "5.4000000000000004",
        "fk_poslovnica": "1"
    },
    {
        "id_skladiste": "2",
        "lokacija": "Vodnikova",
        "velicina(m2)": "5.4000000000000004",
        "fk_poslovnica": "1"
    }
]
```

### HTTP Request
`GET Skladista`


<!-- END_226e219adf707e87fbe1e6f16766f653 -->

<!-- START_5d3efbbac10f2c6f18ba999b5b765298 -->
## SlobodniKontejneri
> Example request:

```bash
curl -X GET \
    -G "http://localhost/SlobodniKontejneri" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/SlobodniKontejneri"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_kontejner": "5",
        "naziv": "Polica 4"
    },
    {
        "id_kontejner": "6",
        "naziv": "Polica 5"
    },
    {
        "id_kontejner": "11",
        "naziv": "Polica 8"
    },
    {
        "id_kontejner": "12",
        "naziv": "Polica 9"
    }
]
```

### HTTP Request
`GET SlobodniKontejneri`


<!-- END_5d3efbbac10f2c6f18ba999b5b765298 -->

<!-- START_09ffb13cdad338c3e44d8180fae3ab16 -->
## DodajLog/{id_kor}/{id_ins}/{id_vrsta}/{feedback?}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/DodajLog/1/1/1/" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/DodajLog/1/1/1/"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`GET DodajLog/{id_kor}/{id_ins}/{id_vrsta}/{feedback?}`


<!-- END_09ffb13cdad338c3e44d8180fae3ab16 -->

<!-- START_efcccdbfa6029eb1164d4f688e2f438c -->
## IspisLog/{id_kor?}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/IspisLog/" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/IspisLog/"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_log": "3",
        "vrsta": "Vracanje",
        "kor_ime": "isudec",
        "email": "isudec@foi.hr",
        "nazivr": "Super Klamer 4200",
        "datum": "2020-01-07 18:37:58.357",
        "feed": ""
    },
    {
        "id_log": "7",
        "vrsta": "Obavijest",
        "kor_ime": "admin",
        "email": "aadmin@foi.hr",
        "nazivr": "Super Klamer 4200",
        "datum": "2020-01-08 12:27:30.240",
        "feed": "Zaklamo sam se"
    },
    {
        "id_log": "8",
        "vrsta": "Obavijest",
        "kor_ime": "admin",
        "email": "aadmin@foi.hr",
        "nazivr": "Super Klamer 4200",
        "datum": "2020-01-08 12:29:38.907",
        "feed": "Odklamao sam se uspjesno"
    },
    {
        "id_log": "14",
        "vrsta": "Feedback",
        "kor_ime": "isudec",
        "email": "isudec@foi.hr",
        "nazivr": "HP 3000",
        "datum": "2020-01-15 08:55:28.460",
        "feed": "Polomljen ekran"
    },
    {
        "id_log": "15",
        "vrsta": "Feedback",
        "kor_ime": "isudec",
        "email": "isudec@foi.hr",
        "nazivr": "ACER Giga X",
        "datum": "2020-01-15 12:02:06.823",
        "feed": "wow joj jaoooo"
    },
    {
        "id_log": "16",
        "vrsta": "Feedback",
        "kor_ime": "isudec",
        "email": "isudec@foi.hr",
        "nazivr": "ACER Giga X",
        "datum": "2020-01-22 16:22:46.647",
        "feed": "hahahahaha"
    },
    {
        "id_log": "17",
        "vrsta": "Feedback",
        "kor_ime": "isudec",
        "email": "isudec@foi.hr",
        "nazivr": "HP 3000",
        "datum": "2020-01-24 14:40:03.283",
        "feed": "EVO TI komentar  "
    }
]
```

### HTTP Request
`GET IspisLog/{id_kor?}`


<!-- END_efcccdbfa6029eb1164d4f688e2f438c -->

<!-- START_93b3bf12e8c1f1a8c949ca6d86e2030b -->
## IspisObavijesti
> Example request:

```bash
curl -X GET \
    -G "http://localhost/IspisObavijesti" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/IspisObavijesti"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_log": "8",
        "vrsta": "Obavijest",
        "kor_ime": "admin",
        "email": "aadmin@foi.hr",
        "nazivr": "Super Klamer 4200",
        "datum": "2020-01-08 12:29:38.907",
        "feed": "Odklamao sam se uspjesno"
    },
    {
        "id_log": "7",
        "vrsta": "Obavijest",
        "kor_ime": "admin",
        "email": "aadmin@foi.hr",
        "nazivr": "Super Klamer 4200",
        "datum": "2020-01-08 12:27:30.240",
        "feed": "Zaklamo sam se"
    }
]
```

### HTTP Request
`GET IspisObavijesti`


<!-- END_93b3bf12e8c1f1a8c949ca6d86e2030b -->

<!-- START_f56992200546ea74ff062770b7e588f5 -->
## IspisNeprocitanih
> Example request:

```bash
curl -X GET \
    -G "http://localhost/IspisNeprocitanih" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/IspisNeprocitanih"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_log": "16",
        "vrsta": "Feedback",
        "kor_ime": "isudec",
        "email": "isudec@foi.hr",
        "nazivr": "ACER Giga X",
        "datum": "2020-01-22 16:22:46.647",
        "feed": "hahahahaha"
    },
    {
        "id_log": "15",
        "vrsta": "Feedback",
        "kor_ime": "isudec",
        "email": "isudec@foi.hr",
        "nazivr": "ACER Giga X",
        "datum": "2020-01-15 12:02:06.823",
        "feed": "wow joj jaoooo"
    },
    {
        "id_log": "14",
        "vrsta": "Feedback",
        "kor_ime": "isudec",
        "email": "isudec@foi.hr",
        "nazivr": "HP 3000",
        "datum": "2020-01-15 08:55:28.460",
        "feed": "Polomljen ekran"
    },
    {
        "id_log": "7",
        "vrsta": "Obavijest",
        "kor_ime": "admin",
        "email": "aadmin@foi.hr",
        "nazivr": "Super Klamer 4200",
        "datum": "2020-01-08 12:27:30.240",
        "feed": "Zaklamo sam se"
    }
]
```

### HTTP Request
`GET IspisNeprocitanih`


<!-- END_f56992200546ea74ff062770b7e588f5 -->

<!-- START_b550f5cdc10632388156067f1864e20d -->
## ProcitajObavijest/{id}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/ProcitajObavijest/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/ProcitajObavijest/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
0
```

### HTTP Request
`GET ProcitajObavijest/{id}`


<!-- END_b550f5cdc10632388156067f1864e20d -->

<!-- START_0c63165a8a8136175312bf3b123ebcf6 -->
## Prijava
> Example request:

```bash
curl -X POST \
    "http://localhost/Prijava" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/Prijava"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST Prijava`


<!-- END_0c63165a8a8136175312bf3b123ebcf6 -->

<!-- START_6ded0a9a223d40286f8ce074102c0016 -->
## SviKorisnici
> Example request:

```bash
curl -X GET \
    -G "http://localhost/SviKorisnici" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/SviKorisnici"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_korisnik": "1",
        "ime": "Robert",
        "prezime": "Sudec",
        "telefon": "0981712383",
        "adresa": "Ksavera 12",
        "email": "isudec@foi.hr",
        "oib": "1234567890",
        "kor_ime": "isudec",
        "lozinka": "zeplusplus",
        "fk_uloga": "1",
        "fk_poslovnica": "1"
    },
    {
        "id_korisnik": "2",
        "ime": "Admin",
        "prezime": "Admin",
        "telefon": "123456789",
        "adresa": "adminova adresa",
        "email": "aadmin@foi.hr",
        "oib": "1234567892",
        "kor_ime": "admin",
        "lozinka": "admin",
        "fk_uloga": "1",
        "fk_poslovnica": "1"
    },
    {
        "id_korisnik": "3",
        "ime": "Ivan",
        "prezime": "Šiser",
        "telefon": "098696969",
        "adresa": "Vinska cesta 3L",
        "email": "isiser@foi.hr",
        "oib": "1133445566",
        "kor_ime": "isiser",
        "lozinka": "cugilom",
        "fk_uloga": "2",
        "fk_poslovnica": "1"
    },
    {
        "id_korisnik": "4",
        "ime": "Moderator",
        "prezime": "Moderator",
        "telefon": "123456987",
        "adresa": "moderatorova adresa",
        "email": "moderator@foi.hr",
        "oib": "564789123",
        "kor_ime": "moderator",
        "lozinka": "moderator",
        "fk_uloga": "2",
        "fk_poslovnica": "1"
    },
    {
        "id_korisnik": "7",
        "ime": "darko",
        "prezime": "darkic",
        "telefon": "01222333",
        "adresa": "nepoznata",
        "email": "darko@foi.hr",
        "oib": "00099922233",
        "kor_ime": "zdarki",
        "lozinka": "gabendo",
        "fk_uloga": "2",
        "fk_poslovnica": "1"
    },
    {
        "id_korisnik": "11",
        "ime": "novi",
        "prezime": "novi",
        "telefon": "123",
        "adresa": "nova adresa",
        "email": "novi",
        "oib": "123",
        "kor_ime": "novi",
        "lozinka": "novi",
        "fk_uloga": "2",
        "fk_poslovnica": "1"
    },
    {
        "id_korisnik": "12",
        "ime": "Irena",
        "prezime": "Ilisevic",
        "telefon": "1111111111",
        "adresa": "Adresa 55",
        "email": "iilisevic@foi.hr",
        "oib": "11111111111",
        "kor_ime": "iilisevic",
        "lozinka": "lozinka",
        "fk_uloga": "2",
        "fk_poslovnica": "1"
    }
]
```

### HTTP Request
`GET SviKorisnici`


<!-- END_6ded0a9a223d40286f8ce074102c0016 -->

<!-- START_87424ce6c7d6a8b733574e1086e0b403 -->
## DodajKorisnika
> Example request:

```bash
curl -X POST \
    "http://localhost/DodajKorisnika" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/DodajKorisnika"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST DodajKorisnika`


<!-- END_87424ce6c7d6a8b733574e1086e0b403 -->

<!-- START_5f19dca137370f67f36ae8d0fcd3968c -->
## SvePoslovnice
> Example request:

```bash
curl -X GET \
    -G "http://localhost/SvePoslovnice" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/SvePoslovnice"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "id_poslovnica": "1",
        "naziv": "Prva poslovnica",
        "telefon": "747474747",
        "email": "poslovnica1@air.hr",
        "oib": "999999999",
        "fk_grad": "1"
    },
    {
        "id_poslovnica": "2",
        "naziv": "Druga poslovnica",
        "telefon": "123456789",
        "email": "poslovnica2@foi.hr",
        "oib": "11111111",
        "fk_grad": "1"
    }
]
```

### HTTP Request
`GET SvePoslovnice`


<!-- END_5f19dca137370f67f36ae8d0fcd3968c -->

<!-- START_9f59fd40848467b6d498d0489acd3261 -->
## AzurirajKorisnika
> Example request:

```bash
curl -X POST \
    "http://localhost/AzurirajKorisnika" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/AzurirajKorisnika"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST AzurirajKorisnika`


<!-- END_9f59fd40848467b6d498d0489acd3261 -->

<!-- START_5588d3dd171d16e8738bb12f83b1750d -->
## MojePosudbe/{id}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/MojePosudbe/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/MojePosudbe/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "nazivr": "HP 3000",
        "nazivtr": "laptop",
        "datum": "2020-01-31 21:19:51.623"
    }
]
```

### HTTP Request
`GET MojePosudbe/{id}`


<!-- END_5588d3dd171d16e8738bb12f83b1750d -->

<!-- START_70acfbaa6539931565b9176b844d735d -->
## MojePosudbe2/{id}
> Example request:

```bash
curl -X GET \
    -G "http://localhost/MojePosudbe2/1" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/MojePosudbe2/1"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "GET",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```


> Example response (200):

```json
[
    {
        "fk_instanca": [
            {
                "id_instanca": "15",
                "kolicina": "0",
                "fk_resurs": "1",
                "fk_kontejner": "7",
                "nfc": "1"
            }
        ],
        "datum": "2020-01-31 21:19:51.623",
        "kolicina": "1",
        "resurs": [
            {
                "id_resurs": "1",
                "nazivr": "HP 3000",
                "kolicina": "3",
                "slika": "laptop.jpg",
                "max_posudba": "4",
                "fk_tip_resursa": "1"
            }
        ]
    }
]
```

### HTTP Request
`GET MojePosudbe2/{id}`


<!-- END_70acfbaa6539931565b9176b844d735d -->

<!-- START_2cd779005bac9991a5840ec6a35aa7ee -->
## Posudi
> Example request:

```bash
curl -X POST \
    "http://localhost/Posudi" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/Posudi"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST Posudi`


<!-- END_2cd779005bac9991a5840ec6a35aa7ee -->

<!-- START_7ba119eb3053c53607078672b414e2f3 -->
## Vrati
> Example request:

```bash
curl -X POST \
    "http://localhost/Vrati" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json"
```

```javascript
const url = new URL(
    "http://localhost/Vrati"
);

let headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
};

fetch(url, {
    method: "POST",
    headers: headers,
})
    .then(response => response.json())
    .then(json => console.log(json));
```



### HTTP Request
`POST Vrati`


<!-- END_7ba119eb3053c53607078672b414e2f3 -->


