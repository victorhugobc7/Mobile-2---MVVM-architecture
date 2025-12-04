import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'job_prediction_view_model.dart';
import '../../DesignSystem/Components/InputField/input_text.dart';
import '../../DesignSystem/Components/InputField/input_text_view_model.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import '../../DesignSystem/Components/Cards/ActionCard/action_card.dart';
import '../../DesignSystem/Components/Cards/ActionCard/action_card_view_model.dart';
import '../../DesignSystem/Components/Checkbox/checkbox.dart';
import '../../DesignSystem/Components/Checkbox/checkbox_view_model.dart';
import '../../DesignSystem/Components/DropdownForm/dropdown_form.dart';
import '../../DesignSystem/Components/DropdownForm/dropdown_form_viewmodel.dart';
import '../../DesignSystem/shared/colors.dart';
import '../../DesignSystem/shared/styles.dart';

class JobPredictionView extends StatelessWidget {
  final JobPredictionViewModel viewModel;
  const JobPredictionView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<JobPredictionViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              title: const Text('Previsão de Salário'),
              backgroundColor: blue_500,
              foregroundColor: white,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: gray_200,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ActionCard.instantiate(
                        viewModel: ActionCardViewModel(
                          headerIcon: Icons.monetization_on,
                          headerTitle: 'Previsor de Salário',
                          description: 'Insira os detalhes da vaga para obter uma estimativa salarial baseada no nosso modelo de predição.',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text('Informações da Empresa', style: heading5Regular),
                  const SizedBox(height: 16),

                  StyledInputField.instantiate(
                    viewModel: InputTextViewModel(
                      controller: vm.ratingController,
                      placeholder: 'Insira a avaliação da empresa (0-5)',
                      password: false,
                      title: 'Avaliação da Empresa',
                      hasTitle: true,
                    ),
                  ),
                  const SizedBox(height: 16),

                  StyledInputField.instantiate(
                    viewModel: InputTextViewModel(
                      controller: vm.companyAgeController,
                      placeholder: 'Insira a idade da empresa em anos',
                      password: false,
                      title: 'Idade da Empresa',
                      hasTitle: true,
                    ),
                  ),
                  const SizedBox(height: 16),

                  StyledInputField.instantiate(
                    viewModel: InputTextViewModel(
                      controller: vm.numCompController,
                      placeholder: 'Insira o número de concorrentes',
                      password: false,
                      title: 'Número de Concorrentes',
                      hasTitle: true,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text('Detalhes da Vaga', style: heading5Regular),
                  const SizedBox(height: 16),

                  Text('Tipo de Cargo', style: labelTextStyle),
                  const SizedBox(height: 8),
                  DropdownFormField<String>(
                    viewModel: DropdownFormViewModel<String>(
                      items: vm.jobTypes,
                      selectedItem: vm.selectedJobType,
                      hint: 'Selecione o tipo de cargo',
                      onChanged: vm.setSelectedJobType,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text('Nível de Senioridade', style: labelTextStyle),
                  const SizedBox(height: 8),
                  DropdownFormField<String>(
                    viewModel: DropdownFormViewModel<String>(
                      items: vm.seniorityLevels,
                      selectedItem: vm.selectedSeniority,
                      hint: 'Selecione a senioridade',
                      onChanged: vm.setSelectedSeniority,
                    ),
                  ),
                  const SizedBox(height: 16),

                  CheckboxNew(
                    viewModel: CheckboxViewModel(title: 'Vaga no mesmo estado da sede'),
                    initialValue: vm.sameState,
                    onChanged: vm.setSameState,
                  ),
                  const SizedBox(height: 24),

                  Text('Habilidades Requeridas', style: heading5Regular),
                  const SizedBox(height: 16),

                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      SizedBox(
                        width: 150,
                        child: CheckboxNew(
                          viewModel: CheckboxViewModel(title: 'Python'),
                          initialValue: vm.pythonYn,
                          onChanged: vm.setPythonYn,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: CheckboxNew(
                          viewModel: CheckboxViewModel(title: 'R'),
                          initialValue: vm.rYn,
                          onChanged: vm.setRYn,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: CheckboxNew(
                          viewModel: CheckboxViewModel(title: 'Spark'),
                          initialValue: vm.spark,
                          onChanged: vm.setSpark,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: CheckboxNew(
                          viewModel: CheckboxViewModel(title: 'AWS'),
                          initialValue: vm.aws,
                          onChanged: vm.setAws,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: CheckboxNew(
                          viewModel: CheckboxViewModel(title: 'Excel'),
                          initialValue: vm.excel,
                          onChanged: vm.setExcel,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionButton.instantiate(
                        viewModel: ActionButtonViewModel(
                          size: ActionButtonSize.large,
                          style: ActionButtonStyle.primary,
                          text: 'Prever Salário',
                          icon: Icons.calculate,
                          onPressed: vm.isLoading ? () {} : vm.predictSalary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      ActionButton.instantiate(
                        viewModel: ActionButtonViewModel(
                          size: ActionButtonSize.medium,
                          style: ActionButtonStyle.secondary,
                          text: 'Limpar',
                          onPressed: vm.clearForm,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  if (vm.isLoading)
                    const Center(child: CircularProgressIndicator()),

                  if (vm.error != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: red_light,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: red_error),
                      ),
                      child: Text(
                        vm.error!,
                        style: bodyRegular.copyWith(color: red_dark),
                      ),
                    ),

                  if (vm.predictedSalary != null && !vm.isLoading)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: blue_100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: blue_400),
                      ),
                      child: Column(
                        children: [
                          Text('Salário Previsto', style: subtitle1Regular),
                          const SizedBox(height: 8),
                          Text(
                            '\$${vm.predictedSalary}K',
                            style: heading4Regular.copyWith(color: blue_600),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${vm.currency} - ${vm.unit}',
                            style: subtitle1Regular.copyWith(color: secondaryInk),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
