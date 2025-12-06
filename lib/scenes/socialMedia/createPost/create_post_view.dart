import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/styles.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/Avatar/avatar.dart';
import '../../../DesignSystem/Components/Avatar/avatar_view_model.dart';
import '../../../DesignSystem/Components/IconLabelButton/icon_label_button.dart';
import '../../../DesignSystem/Components/IconLabelButton/icon_label_button_view_model.dart';
import '../../../DesignSystem/Components/CreatePostAppBar/create_post_app_bar.dart';
import '../../../DesignSystem/Components/CreatePostAppBar/create_post_app_bar_view_model.dart';
import '../../../DesignSystem/Components/SwitchButton/switch_button.dart';
import '../../../DesignSystem/Components/SwitchButton/switch_button_viewmodel.dart';
import 'create_post_view_model.dart';

class CreatePostView extends StatelessWidget {
  final CreatePostViewModel viewModel;

  const CreatePostView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<CreatePostViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: white,
            appBar: CreatePostAppBar.instantiate(
              viewModel: CreatePostAppBarViewModel(
                onBackPressed: vm.goBack,
                onPostPressed: vm.submitPost,
                isPostEnabled: vm.canPost,
                isPosting: vm.isPosting,
              ),
            ),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildUserHeader(vm),
                              _buildContentInput(vm),
                              if (vm.selectedImage != null) _buildImagePreview(vm),
                            ],
                          ),
                        ),
                      ),
                      _buildBottomBar(vm),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildUserHeader(CreatePostViewModel vm) {
    return Padding(
      padding: EdgeInsets.all(small),
      child: Row(
        children: [
          Avatar.instantiate(
            viewModel: AvatarViewModel(
              initials: vm.userAvatar,
              size: 48,
            ),
          ),
          SizedBox(width: extraSmall),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vm.userName,
                style: labelTextStyle.copyWith(color: primaryInk, fontSize: 16),
              ),
              Container(
                margin: EdgeInsets.only(top: tripleXS),
                padding: EdgeInsets.symmetric(horizontal: doubleXS, vertical: tripleXS),
                decoration: BoxDecoration(
                  border: Border.all(color: gray_400),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.public, size: 14, color: gray_600),
                    SizedBox(width: tripleXS),
                    Text(
                      'Qualquer pessoa',
                      style: label2Regular.copyWith(color: gray_600),
                    ),
                    const Icon(Icons.arrow_drop_down, size: 16, color: gray_600),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentInput(CreatePostViewModel vm) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: small),
      child: TextField(
        controller: vm.contentController,
        onChanged: (_) => vm.updateContent(),
        maxLines: null,
        minLines: 5,
        decoration: InputDecoration(
          hintText: 'Sobre o que você quer falar?',
          hintStyle: bodyRegular.copyWith(color: gray_500),
          border: InputBorder.none,
        ),
        style: bodyRegular.copyWith(color: primaryInk),
      ),
    );
  }

  Widget _buildImagePreview(CreatePostViewModel vm) {
    return Container(
      margin: EdgeInsets.all(small),
      child: Stack(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: gray_200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 64, color: gray_400),
            ),
          ),
          Positioned(
            top: doubleXS,
            right: doubleXS,
            child: GestureDetector(
              onTap: vm.removeImage,
              child: Container(
                padding: EdgeInsets.all(tripleXS),
                decoration: const BoxDecoration(
                  color: primaryInk,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(CreatePostViewModel vm) {
    return Container(
      padding: EdgeInsets.all(small),
      decoration: const BoxDecoration(
        color: white,
        border: Border(top: BorderSide(color: gray_300)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: IconLabelButton.instantiate(
                    viewModel: IconLabelButtonViewModel(
                      icon: Icons.image,
                      label: 'Foto',
                      onTap: vm.selectImage,
                    ),
                  ),
                ),
                Expanded(
                  child: IconLabelButton.instantiate(
                    viewModel: IconLabelButtonViewModel(
                      icon: Icons.videocam,
                      label: 'Vídeo',
                      onTap: vm.onAddVideoTapped,
                    ),
                  ),
                ),
                Expanded(
                  child: IconLabelButton.instantiate(
                    viewModel: IconLabelButtonViewModel(
                      icon: Icons.event,
                      label: 'Evento',
                      onTap: vm.onAddEventTapped,
                    ),
                  ),
                ),
                Expanded(
                  child: IconLabelButton.instantiate(
                    viewModel: IconLabelButtonViewModel(
                      icon: Icons.article,
                      label: 'Artigo',
                      onTap: vm.onAddArticleTapped,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: small),
            Row(
              children: [
                const Icon(Icons.chat_bubble_outline, size: 20, color: gray_600),
                SizedBox(width: doubleXS),
                Text(
                  'Qualquer pessoa pode comentar',
                  style: label2Regular.copyWith(color: gray_600),
                ),
                const Spacer(),
                SwitchButton.instantiate(
                  viewModel: SwitchButtonViewModel(
                    value: vm.anyoneCanComment,
                    onChanged: vm.setAnyoneCanComment,
                    showInlineLabel: true,
                    onLabel: 'Sim',
                    offLabel: 'Não',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
