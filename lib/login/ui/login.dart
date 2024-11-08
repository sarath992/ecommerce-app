import 'package:ecomm_app/login/bloc/login_bloc.dart';
import 'package:ecomm_app/login/bloc/login_event.dart';
import 'package:ecomm_app/login/bloc/login_state.dart';
import 'package:ecomm_app/login/repository/login_repo.dart';
import 'package:ecomm_app/signup/ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (context) => LoginBloc(authRepository: AuthRepository()),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() {
    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      BlocProvider.of<LoginBloc>(context).add(LoginSubmitEvent(
        username: username,
        password: password,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          setState(() {
            _isLoading = true;
          });
        } else if (state is LoginSuccessState) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is LoginFailureState) {
          setState(() {
            _isLoading = false;
          });
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(state.error),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isLoading ? null : _login,
            child: _isLoading ? CircularProgressIndicator() : Text('Login'),
          ),
            SizedBox(height: 20),
          // Elevated TextButton to navigate to Signup page
          TextButton(
            onPressed: () {
             Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                            ),
                        ); 
            },
            child: Text(
              'Create an Account',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
