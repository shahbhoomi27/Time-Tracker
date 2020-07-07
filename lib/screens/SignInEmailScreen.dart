import 'package:flutter/material.dart';
import 'package:time_tracker_app/services/StringValidator.dart';
import 'package:time_tracker_app/services/auth.dart';
import 'package:time_tracker_app/widgets/MyRaisedButton.dart';

enum formTypeEnum { signInEnum, registerEnum }

class SignInEmailScreen extends StatefulWidget with EmailPasswordValidator {
  SignInEmailScreen(@required this.auth);

  AuthBase auth;

  @override
  _SignInEmailScreenState createState() => _SignInEmailScreenState();
}

class _SignInEmailScreenState extends State<SignInEmailScreen> {
  TextEditingController emailEditor = TextEditingController();

  TextEditingController passwordEditor = TextEditingController();

  formTypeEnum _formType = formTypeEnum.signInEnum;

  bool _submitted = false;
  bool _isLoading = false;

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  Future<void> signInOrRegUser() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if (_formType == formTypeEnum.signInEnum)
        await widget.auth
            .signInWithEmail(emailEditor.text, passwordEditor.text);
      else
        await widget.auth
            .createUserWithEmail(emailEditor.text, passwordEditor.text);

      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }finally{
      setState(() {
        _isLoading = false;
      });

    }
  }

  void emailEditingComplete() {

    final _newFocusNode = widget.emailValidator.isValid(emailEditor.text) ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(_newFocusNode);
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _primaryText =
        _formType == formTypeEnum.signInEnum ? "Sign in" : "Create an account";
    final _secondaryText = _formType == formTypeEnum.signInEnum
        ? "Need an account? Register"
        : "Have an account? Sign in";

    bool _submitEnable = widget.emailValidator.isValid(emailEditor.text) &&
        widget.passwordValidator.isValid(passwordEditor.text) && !_isLoading;




    TextField _emailTextField(){
      bool _showEmailMsg =
          _submitted && !widget.emailValidator.isValid(emailEditor.text);
      return TextField(
        onChanged: (email) => _updateState(),
        controller: emailEditor,
        focusNode: _emailFocusNode,
        onEditingComplete: emailEditingComplete,
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            hintText: "test@test.com",
            labelText: "Email",
            errorText:
            _showEmailMsg ? widget.invalidEmailMsg : null,
        enabled: _isLoading == false),
      );
    }

    TextField _passwordTextField(){
      bool _showPasswordMsg =
          _submitted && !widget.passwordValidator.isValid(passwordEditor.text);
      return TextField(
        onChanged: (password) => _updateState(),
        controller: passwordEditor,
        focusNode: _passwordFocusNode,
        onEditingComplete: signInOrRegUser,
        textInputAction: TextInputAction.done,
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          errorText:
          _showPasswordMsg ? widget.invalidPasswordMsg : null,
          enabled: _isLoading == false,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Sign in"),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _emailTextField(),
                  SizedBox(
                    height: 8.0,
                  ),
                  _passwordTextField(),
                  SizedBox(
                    height: 12.0,
                  ),
                  MyRaisedButton(
                    mPressed: _submitEnable ? signInOrRegUser : null,
                    mheight: 44.0,
                    mColor: Colors.indigo,
                    mChild: Text(
                      _primaryText,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _submitted = false;
                        _formType = _formType == formTypeEnum.signInEnum
                            ? formTypeEnum.registerEnum
                            : formTypeEnum.signInEnum;
                      });
//                      FocusScope.of(context).requestFocus(_emailFocusNode);
                      emailEditor.clear();
                      passwordEditor.clear();
                    },
                    child: Text(_secondaryText),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
