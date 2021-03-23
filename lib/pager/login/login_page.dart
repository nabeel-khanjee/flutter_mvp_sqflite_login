import 'package:flutter/material.dart';
import 'package:flutter_sqflite_mvp_architechture/data/data_helper.dart';
import 'package:flutter_sqflite_mvp_architechture/models/user.dart';
import 'package:flutter_sqflite_mvp_architechture/pager/login/login_presenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading;
  final formkey = new GlobalKey<FormState>();
  final scaffoldKer = new GlobalKey<ScaffoldState>();

  String _username, _password;
  LoginPagePresernter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresernter(this);
  }

  void _submit() {
    final form = formkey.currentState;
    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
    }
  }

  void _showsnakeBar(String text) {
    scaffoldKer.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Login"),
      color: Colors.greenAccent,
    );
    var loginForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        new Text(
          "Sqflite App",
          textScaleFactor: 2.0,
        ),
        new Form(
          child: new Column(
            children: [
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: new InputDecoration(labelText: "Username "),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: new InputDecoration(labelText: "Password "),
                ),
              ),
            ],
          ),
          key: formkey,
        ),
        loginBtn
      ],
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login Page"),
      ),
      key: scaffoldKer,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    // TODO: implement onLoginError
    _showsnakeBar(error);
  }

  @override
  Future<void> onLoginSuccess(User user) async {
    // TODO: implement onLoginSuccess
    _showsnakeBar(user.toString());
    setState(() {
      _isLoading = false;
    });
    var db = new DatabaseHelper();
    await db.saveUser(user);
    Navigator.of(context).pushNamed("/home");
  }
}
