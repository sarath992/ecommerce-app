
import 'package:ecomm_app/login/ui/login.dart';
import 'package:ecomm_app/product_list/ui/product_list_page.dart';
import 'package:ecomm_app/signup/bloc/signup_bloc.dart';
import 'package:ecomm_app/signup/bloc/signup_event.dart';
import 'package:ecomm_app/signup/bloc/signup_state.dart';
import 'package:ecomm_app/signup/model/signup_model.dart';
import 'package:ecomm_app/signup/repository/signup_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(authService: authService),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    } else if (state is RegisterFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.error)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductListPage(
                              ),
                            ),
                          );
                        final request = RegisterRequest(
                          username: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        context.read<RegisterBloc>().add(RegisterUser(request));
                      },
                      child: Text('Register'),
                    );
                  },
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Navigate to Login screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text('Already have an account? Login'),
                ),
                
              ],
                  

            ),
          ),
        ),
      ),
    );
  }

  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
