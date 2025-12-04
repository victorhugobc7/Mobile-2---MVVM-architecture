import 'package:flutter/material.dart';
import 'login_view_model.dart';
import '../../DesignSystem/Components/InputField/input_text.dart';
import '../../DesignSystem/Components/InputField/input_text_view_model.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/shared/colors.dart';
import '../../DesignSystem/shared/styles.dart';

class LoginView extends StatefulWidget {
  final LoginViewModel viewModel;
  const LoginView({super.key, required this.viewModel});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: heading4Regular),
            const SizedBox(height: 32),

            StyledInputField.instantiate(
              viewModel: InputTextViewModel(
                controller: _userController,
                placeholder: 'Enter your username',
                password: false,
                title: 'Username',
                hasTitle: true,
              ),
            ),
            const SizedBox(height: 16),

            StyledInputField.instantiate(
              viewModel: InputTextViewModel(
                controller: _passwordController,
                placeholder: 'Enter your password',
                password: true,
                title: 'Password',
                hasTitle: true,
              ),
            ),
            const SizedBox(height: 32),

            _isLoading
                ? const CircularProgressIndicator()
                : ActionButton.instantiate(
                    viewModel: ActionButtonViewModel(
                      size: ActionButtonSize.large,
                      style: ActionButtonStyle.primary,
                      text: 'Login',
                      icon: Icons.login,
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        await widget.viewModel.performLogin(
                          _userController.text,
                          _passwordController.text,
                          onSuccess: (name, address) {
                            widget.viewModel.presentHome(name, address);
                          },
                        );
                        setState(() => _isLoading = false);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}