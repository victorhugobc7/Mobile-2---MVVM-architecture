import 'package:flutter/material.dart';
import 'home_view_model.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/Components/Cards/ActionCard/action_card.dart';
import '../../DesignSystem/Components/Cards/ActionCard/action_card_view_model.dart';
import '../../DesignSystem/shared/colors.dart';
import '../../DesignSystem/shared/styles.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: blue_500,
        foregroundColor: white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: viewModel.logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bem vindo, ${viewModel.userName}!', style: heading4Regular),
            const SizedBox(height: 8),
            Text(viewModel.userAddress, style: subtitle1Regular.copyWith(color: secondaryInk)),
            const SizedBox(height: 32),

            Text('Ações', style: heading5Regular),
            const SizedBox(height: 16),

            _buildNavigationCard(
              context,
              title: 'Predição de salário extremamente correta',
              description: 'faz uma prévia do salário dependendo do seus dados',
              icon: Icons.monetization_on,
              color: blue_500,
              onTap: viewModel.goToJobPrediction,
            ),

            const Spacer(),

            Center(
              child: ActionButton.instantiate(
                viewModel: ActionButtonViewModel(
                  size: ActionButtonSize.large,
                  style: ActionButtonStyle.secondary,
                  text: 'Logout',
                  icon: Icons.exit_to_app,
                  onPressed: viewModel.logout,
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: gray_300),
          boxShadow: [
            BoxShadow(
              color: gray_400.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: heading5Regular.copyWith(color: primaryInk)),
                  const SizedBox(height: 4),
                  Text(description, style: subtitle1Regular.copyWith(color: secondaryInk)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: gray_500),
          ],
        ),
      ),
    );
  }
}
