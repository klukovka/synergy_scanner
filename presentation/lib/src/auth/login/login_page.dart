import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login'),
            ElevatedButton(
                onPressed: () => StoreProvider.of<AppState>(context)
                    .dispatch(OpenPageAction(Destination.signUp)),
                child: const Text('sign up'))
          ],
        ),
      ),
    );
  }
}
