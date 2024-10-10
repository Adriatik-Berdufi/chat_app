import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  //images path
  String asset = 'assets/images/'; //const per percorso img
  bool isPasswordVisible = false; //stato iniziale della visibilità della pass
  bool isLogIn = true; //stato iniziale del login mode
  final _form = GlobalKey<FormState>(); // Form key

  // Variabili input form
  var _enterEmail = '';
  var _enterPassword = '';
  var _confirmPassword = '';

  void _submit() {
    final isValid = _form.currentState!.validate();
    if (isValid) {
      _form.currentState!.save(); // Salva i valori del form
      print(_confirmPassword);
      // Controllo se le password corrispondono
      if (!isLogIn && _enterPassword != _confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Le password non corrispondono!'),
          ),
        );
        return; //esci se le password non corrispondono
      }

      //se tutto è valido
      print(_enterEmail);
      print(_enterPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //container per img
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('${asset}chat.png'),
              ),
              //card per input
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //input email
                          TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Email Address'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enterEmail = value!;
                            },
                          ),
                          //input password
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: !isPasswordVisible,
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Minimum 6 characters';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _enterPassword = value!;
                            },
                          ),
                          //input for confirm passwor singup mode
                          if (!isLogIn)
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordVisible = !isPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              obscureText: !isPasswordVisible,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Minimum 6 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _confirmPassword = value!;
                              },
                            ),
                          const SizedBox(height: 12),
                          //button singUp or logIn
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text(isLogIn ? 'Log In' : 'Sign Up'),
                          ),
                          //textvutton for switch login and sigup
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLogIn = !isLogIn;
                              });
                            },
                            child: Text(isLogIn
                                ? 'Create an account'
                                : 'I already have an account!'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
