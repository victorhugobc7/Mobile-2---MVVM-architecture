import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_view_model.dart';
import '../../DesignSystem/Components/InputField/input_text.dart';
import '../../DesignSystem/Components/InputField/input_text_view_model.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/shared/colors.dart';
import '../../DesignSystem/shared/styles.dart';
import '../../DesignSystem/shared/spacing.dart';

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
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: large, vertical: extraLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'lib/DesignSystem/Assets/ic_launcher_APP.svg',
                width: 80,
                height: 80,
                placeholderBuilder: (context) => Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: blue_500,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.work, color: white, size: 48),
                ),
              ),
              SizedBox(height: large),
              
              Text('Login', style: title4.copyWith(color: primaryInk)),
              SizedBox(height: extraLarge),

              StyledInputField.instantiate(
                viewModel: InputTextViewModel(
                  controller: _userController,
                  placeholder: 'Enter your username',
                  password: false,
                  title: 'Username',
                  hasTitle: true,
                ),
              ),
              SizedBox(height: large),

              StyledInputField.instantiate(
                viewModel: InputTextViewModel(
                  controller: _passwordController,
                  placeholder: 'Enter your password',
                  password: true,
                  title: 'Password',
                  hasTitle: true,
                ),
              ),
              SizedBox(height: extraLarge),

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
      ),
    );
  }
}