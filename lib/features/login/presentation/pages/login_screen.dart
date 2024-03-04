import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tdd_clean_arch/core/providers.dart';

import '../../../../core/utils/validator.dart';
import '../../domain/entities/user.dart';
import 'home_page.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(loginNotifierProvider.notifier);

    ref.listen(loginNotifierProvider, (previous, next) {
      if(next.isLoggedIn) {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => HomePage()));
      } else {
        var snackBar = const SnackBar(content: Text('Something went wrong. Please try again.'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    void _onClickLogin(WidgetRef ref) async {
      if(_formKey.currentState!.validate()) {
        final username = _usernameController.text;
        final password = _passwordController.text;

        final user = User(username: username, password: password);
        loginNotifier.login(user);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(label: Text('Username')),
                validator: (value) => Validator.validateUsername(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
                validator: (value) => Validator.validatePassword(value),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _onClickLogin(ref);
              },
              key: const Key('Login Button'),
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
