import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../DesignSystem/shared/colors.dart';
import '../../../DesignSystem/shared/spacing.dart';
import '../../../DesignSystem/Components/EmptyState/empty_state.dart';
import '../../../DesignSystem/Components/SimpleAppBar/simple_app_bar.dart';
import '../../../DesignSystem/Components/SearchBar/search_bar.dart';
import '../../../DesignSystem/Components/MessageItem/message_item.dart';
import '../../../DesignSystem/Components/MessageItem/message_item_view_model.dart';
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
            appBar: SimpleAppBar.instantiate(viewModel: vm.appBarViewModel),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(small),
                        child: DSSearchBar.instantiate(viewModel: vm.searchBarViewModel),
                      ),
                      Expanded(
                        child: vm.messages.isEmpty
                            ? EmptyState.instantiate(viewModel: vm.emptyStateViewModel)
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

  Widget _buildMessageItem(MessageModel message, MessagesViewModel vm) {
    return MessageItem.instantiate(
      viewModel: MessageItemViewModel(
        id: message.id,
        senderName: message.contactName,
        avatarInitials: message.contactAvatar,
        lastMessage: message.lastMessage,
        timeAgo: message.timeAgo,
        isUnread: message.unreadCount > 0,
        unreadCount: message.unreadCount,
        isOnline: message.isOnline,
        onTap: () => vm.openConversation(message.id),
      ),
    );
  }
}
