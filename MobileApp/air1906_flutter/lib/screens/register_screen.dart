import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Registracija',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 38,
              ),
            ),
            SingleChildScrollView(
              child: Card(
                elevation: 12,
                margin: EdgeInsets.all(30),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Ime'),
                            keyboardType: TextInputType.text,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Prezime'),
                            keyboardType: TextInputType.text,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'OIB'),
                            keyboardType: TextInputType.number,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'E-mail'),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Lozinka'),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Ponovi lozinku'),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            RaisedButton(
              child: Text(
                'Registriraj me',
                style: TextStyle(color: Colors.white),
              ),
              elevation: 10,
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            FlatButton(
              child: Text('Već imaš račun? Prijavi se'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
