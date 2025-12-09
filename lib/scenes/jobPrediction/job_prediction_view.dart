import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'job_prediction_view_model.dart';
import '../../DesignSystem/Components/InputField/input_text.dart';
import '../../DesignSystem/Components/InputField/input_text_view_model.dart';
import '../../DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import '../../DesignSystem/Components/Cards/ActionCard/action_card.dart';
import '../../DesignSystem/Components/Cards/ActionCard/action_card_view_model.dart';
import '../../DesignSystem/Components/Checkbox/checkbox.dart';
import '../../DesignSystem/Components/Checkbox/checkbox_view_model.dart';
import '../../DesignSystem/Components/DropdownForm/dropdown_form.dart';
import '../../DesignSystem/Components/DropdownForm/dropdown_form_viewmodel.dart';
import '../../DesignSystem/shared/colors.dart';
import '../../DesignSystem/shared/styles.dart';
import '../../DesignSystem/shared/spacing.dart';

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
              title: Text('Previsão de Salário', style: labelTextStyle.copyWith(color: white)),
              backgroundColor: blue_500,
              foregroundColor: white,
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(medium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: gray_200,
                    child: Padding(
                      padding: EdgeInsets.all(small),
                      child: ActionCard.instantiate(
                        viewModel: ActionCardViewModel(
                          headerIcon: Icons.monetization_on,
                          headerTitle: 'Previsor de Salário',
                          description: 'Insira os detalhes da vaga para obter uma estimativa salarial baseada no nosso modelo de predição.',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: medium),

                  Text('Informações da Empresa', style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18)),
                  SizedBox(height: small),

                  StyledInputField.instantiate(
                    viewModel: InputTextViewModel(
                      controller: vm.ratingController,
                      placeholder: 'Insira a avaliação da empresa (0-5)',
                      password: false,
                      title: 'Avaliação da Empresa',
                      hasTitle: true,
                    ),
                  ),
                  SizedBox(height: small),

                  StyledInputField.instantiate(
                    viewModel: InputTextViewModel(
                      controller: vm.companyAgeController,
                      placeholder: 'Insira a idade da empresa em anos',
                      password: false,
                      title: 'Idade da Empresa',
                      hasTitle: true,
                    ),
                  ),
                  SizedBox(height: small),

                  StyledInputField.instantiate(
                    viewModel: InputTextViewModel(
                      controller: vm.numCompController,
                      placeholder: 'Insira o número de concorrentes',
                      password: false,
                      title: 'Número de Concorrentes',
                      hasTitle: true,
                    ),
                  ),
                  SizedBox(height: medium),

                  Text('Detalhes da Vaga', style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18)),
                  SizedBox(height: small),

                  Text('Tipo de Cargo', style: labelTextStyle.copyWith(color: primaryInk)),
                  SizedBox(height: doubleXS),
                  DropdownFormField<String>(
                    viewModel: DropdownFormViewModel<String>(
                      items: vm.jobTypes,
                      selectedItem: vm.selectedJobType,
                      hint: 'Selecione o tipo de cargo',
                      onChanged: vm.setSelectedJobType,
                    ),
                  ),
                  SizedBox(height: small),

                  Text('Nível de Senioridade', style: labelTextStyle.copyWith(color: primaryInk)),
                  SizedBox(height: doubleXS),
                  DropdownFormField<String>(
                    viewModel: DropdownFormViewModel<String>(
                      items: vm.seniorityLevels,
                      selectedItem: vm.selectedSeniority,
                      hint: 'Selecione a senioridade',
                      onChanged: vm.setSelectedSeniority,
                    ),
                  ),
                  SizedBox(height: small),

                  CheckboxNew(
                    viewModel: CheckboxViewModel(title: 'Vaga no mesmo estado da sede'),
                    initialValue: vm.sameState,
                    onChanged: vm.setSameState,
                  ),
                  SizedBox(height: medium),

                  Text('Habilidades Requeridas', style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18)),
                  SizedBox(height: small),

                  Wrap(
                    spacing: small,
                    runSpacing: doubleXS,
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
                  SizedBox(height: large),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionButton.instantiate(
                        viewModel: vm.predictButtonViewModel,
                      ),
                      SizedBox(width: small),
                      ActionButton.instantiate(
                        viewModel: vm.clearButtonViewModel,
                      ),
                    ],
                  ),
                  SizedBox(height: large),

                  if (vm.isLoading)
                    const Center(child: CircularProgressIndicator()),

                  if (vm.error != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(small),
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
                      padding: EdgeInsets.all(medium),
                      decoration: BoxDecoration(
                        color: blue_100,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: blue_400),
                      ),
                      child: Column(
                        children: [
                          Text('Salário Previsto', style: bodyRegular.copyWith(color: secondaryInk)),
                          SizedBox(height: doubleXS),
                          Text(
                            '\$${vm.predictedSalary}K',
                            style: title4.copyWith(color: blue_600),
                          ),
                          SizedBox(height: doubleXS),
                          Text(
                            '${vm.currency} - ${vm.unit}',
                            style: label2Regular.copyWith(color: secondaryInk),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: large),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
