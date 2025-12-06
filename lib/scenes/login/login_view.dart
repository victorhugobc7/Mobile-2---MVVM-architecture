import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'login_view_model.dart';
import '../../DesignSystem/Components/InputField/input_text.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/shared/colors.dart';
import '../../DesignSystem/shared/styles.dart';
import '../../DesignSystem/shared/spacing.dart';

class LoginView extends StatelessWidget {
  final LoginViewModel viewModel;
  const LoginView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<LoginViewModel>(
        builder: (context, vm, child) {
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
                    
                    Text('Login', style: title2.copyWith(color: primaryInk)),
                    SizedBox(height: extraLarge),

                    StyledInputField.instantiate(viewModel: vm.usernameViewModel),
                    SizedBox(height: large),

                    StyledInputField.instantiate(viewModel: vm.passwordViewModel),
                    SizedBox(height: extraLarge),

                    vm.isLoading
                        ? const CircularProgressIndicator()
                        : ActionButton.instantiate(viewModel: vm.loginButtonViewModel),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}