import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/styles.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/Avatar/avatar.dart';
import '../../../DesignSystem/Components/Avatar/avatar_view_model.dart';
import 'messages_view_model.dart';

class MessagesView extends StatelessWidget {
  final MessagesViewModel viewModel;

  const MessagesView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<MessagesViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: white,
            appBar: AppBar(
              backgroundColor: white,
              elevation: 1,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: primaryInk),
                onPressed: vm.goBack,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mensagens',
                    style: labelTextStyle.copyWith(color: primaryInk, fontSize: 18),
                  ),
                  if (vm.totalUnread > 0)
                    Text(
                      '${vm.totalUnread} não lida${vm.totalUnread > 1 ? 's' : ''}',
                      style: label2Regular.copyWith(color: gray_600),
                    ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.filter_list, color: gray_600),
                  onPressed: vm.onFilterTapped,
                ),
                IconButton(
                  icon: const Icon(Icons.edit_square, color: gray_600),
                  onPressed: vm.composeNewMessage,
                ),
              ],
            ),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      _buildSearchBar(vm),
                      Expanded(
                        child: vm.messages.isEmpty
                            ? _buildEmptyState()
                            : ListView.separated(
                                itemCount: vm.messages.length,
                                separatorBuilder: (_, __) => const Divider(
                                  height: 1,
                                  indent: 80,
                                ),
                                itemBuilder: (context, index) {
                                  return _buildMessageItem(
                                    vm.messages[index],
                                    vm,
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(MessagesViewModel vm) {
    return Container(
      padding: EdgeInsets.all(small),
      child: TextField(
        onChanged: vm.updateSearch,
        decoration: InputDecoration(
          hintText: 'Pesquisar mensagens',
          hintStyle: bodyRegular.copyWith(color: gray_500),
          prefixIcon: const Icon(Icons.search, color: gray_500),
          filled: true,
          fillColor: gray_200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: small, vertical: extraSmall),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.message_outlined, size: 80, color: gray_400),
          SizedBox(height: small),
          Text(
            'Nenhuma mensagem',
            style: labelTextStyle.copyWith(color: gray_600, fontSize: 18),
          ),
          SizedBox(height: doubleXS),
          Text(
            'Comece uma conversa!',
            style: label2Regular.copyWith(color: gray_500),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(MessageModel message, MessagesViewModel vm) {
    return InkWell(
      onTap: () => vm.openConversation(message.id),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: small, vertical: extraSmall),
        child: Row(
          children: [
            Avatar.instantiate(
              viewModel: AvatarViewModel(
                initials: message.contactAvatar,
                size: 56,
                showOnlineIndicator: true,
                isOnline: message.isOnline,
              ),
            ),
            SizedBox(width: extraSmall),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.contactName,
                          style: bodyRegular.copyWith(
                            fontWeight: message.unreadCount > 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: primaryInk,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        message.timeAgo,
                        style: label2Regular.copyWith(
                          color: message.unreadCount > 0 ? blue_500 : gray_500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: tripleXS),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.lastMessage,
                          style: label2Regular.copyWith(
                            color: message.unreadCount > 0
                                ? primaryInk
                                : gray_600,
                            fontWeight: message.unreadCount > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (message.unreadCount > 0)
                        Container(
                          margin: EdgeInsets.only(left: doubleXS),
                          padding: EdgeInsets.symmetric(
                            horizontal: doubleXS,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: blue_500,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            message.unreadCount.toString(),
                            style: label2Regular.copyWith(
                              color: white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
