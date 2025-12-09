import 'package:flutter/material.dart';
import 'home_view_model.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/shared/colors.dart';
import '../../DesignSystem/shared/styles.dart';
import '../../DesignSystem/shared/spacing.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel viewModel;
  const HomeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text('Home', style: labelTextStyle.copyWith(color: white)),
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
        padding: EdgeInsets.all(medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bem vindo, ${viewModel.userName}!', style: title4.copyWith(color: primaryInk)),
            SizedBox(height: doubleXS),
            Text(viewModel.userAddress, style: bodyRegular.copyWith(color: secondaryInk)),
            SizedBox(height: large),

            Text('Ações', style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18)),
            SizedBox(height: small),

            _buildNavigationCard(
              context,
              title: 'Predição de salário extremamente correta',
              description: 'faz uma prévia do salário dependendo do seus dados',
              icon: Icons.monetization_on,
              color: blue_500,
              onTap: viewModel.goToJobPrediction,
            ),

            SizedBox(height: extraSmall),

            _buildNavigationCard(
              context,
              title: 'Rede Social Profissional',
              description: 'Conecte-se com profissionais e acompanhe suas publicações',
              icon: Icons.people,
              color: navy_700,
              onTap: viewModel.goToSocialFeed,
            ),

            const Spacer(),

            Center(
              child: ActionButton.instantiate(
                viewModel: viewModel.logoutButtonViewModel,
              ),
            ),
            SizedBox(height: medium),
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
        padding: EdgeInsets.all(medium - 4),
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
              padding: EdgeInsets.all(extraSmall),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            SizedBox(width: small),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: labelTextStyle.copyWith(color: primaryInk)),
                  SizedBox(height: tripleXS),
                  Text(description, style: label2Regular.copyWith(color: secondaryInk)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: gray_500),
          ],
        ),
      ),
    );
  }
}
